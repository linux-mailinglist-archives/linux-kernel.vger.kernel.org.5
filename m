Return-Path: <linux-kernel+bounces-137253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5CB89DF88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE9F294213
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FBC13B590;
	Tue,  9 Apr 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME3/PhR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0513667F;
	Tue,  9 Apr 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677581; cv=none; b=IdC+H4IznzkpYbTLgRo53AfgI0HQrBdmaVmJ9wiaDywZ89nngeVoeqWnJxq72YKtDLRTwHaXE/0QtAGyrq2g4V4kTTItyif8JCy3P8SKm5brR4Pm+vzpW6r4KDuJ576rdK8+J1sC15DTo2dJFCj6nWI3OfgsMk5gK2RLbvKVZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677581; c=relaxed/simple;
	bh=AMqXgBQum094kgOVcj2SwYkBLHwOfKK/allxjYwE3+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKaMJjK3fP6WYtx1RWh22Qo8u1b2vLe3RD1H5EHTQOg3aNR2FQJ5aNL4pdma35njoeMWa/yEnchWq1jwvuuCYM2vHVArl9axSr03eRaOF2FOuIhE2TfZyumXbN7cGOEEzdoSpKLJdBqefjDiJ9wyZcBUhvSsdUx+wwHHUKuvTzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME3/PhR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1CFC433C7;
	Tue,  9 Apr 2024 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712677580;
	bh=AMqXgBQum094kgOVcj2SwYkBLHwOfKK/allxjYwE3+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ME3/PhR/h55ot5LNZCP2rRlhgrTbr7UeqHe86M6NdUn7tNhxqz/Mi2YYEB2Mltvor
	 0m4tTNuT0NyzxdWBgK12nxsp8ciAmeXE4OcDbQzXHWhs1xOXsMMzsIxr+Ne2lTuopm
	 EP3DZ4x5P3Ka6J+iAKOpG/6CJ/nYE90Ovc2Ad8CaTHU6JzLvdKlJhCqqmmeKp7LOoe
	 igV529SqxDWzS/u05SxAnloc1kPd45fhO5+iyK895NLzMnT/jBCf4wnHtERY0aEcNe
	 ksLoqmqaJU5YWGOC5kqX+Rc/iis2gKZdbpGGnf4XfITqON1zOtbDcF9eqVCgn56w0i
	 o0BHFC5i6Ruqg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ruDfr-0000000038F-1wBX;
	Tue, 09 Apr 2024 17:46:16 +0200
Date: Tue, 9 Apr 2024 17:46:15 +0200
From: Johan Hovold <johan@kernel.org>
To: =?utf-8?Q?=C5=81ukasz?= Majczak <lma@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
Message-ID: <ZhVix-HJrqQbiPrB@hovoldconsulting.com>
References: <20240405102436.3479210-1-lma@chromium.org>
 <ZhOccGFkTFkUkRUI@hovoldconsulting.com>
 <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>

On Tue, Apr 09, 2024 at 12:53:43PM +0200, Łukasz Majczak wrote:

> > Can you please explain why this would not a problem for all future
> > transactions as well?

> The problem is that the probe function calling i2c_smbus_read_byte()
> is not aware that
> uC on the other end is in a deep sleep state so the first read will
> fail and so the whole probe.
> 
> In a normal scenario, when a user touches the touchpad (when it is in
> a deep sleep), the touch will first wake up the uC and
> then generate an interrupt to AP, so in this case the touchpad is
> fully awake and operational.

Sure, but what about other transactions that are initiated by the host
(e.g. SET_POWER)?

Perhaps this hack at probe is enough for your use case, but is an
incomplete hack and at a minimum you'd need to add a comment explaining
why it is there.

Johan

