Return-Path: <linux-kernel+bounces-145276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768BE8A51CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1DD1F23115
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D49071758;
	Mon, 15 Apr 2024 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+Ec+RO+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC07A5A108;
	Mon, 15 Apr 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188259; cv=none; b=LjDZbj7VllD7VzIAhuSfc6ECymuiTZV/TVHZawfWYt84hGpH6xoRc6KphRc5GNHLmU+eAoCcmZ/5PSlTGV5D1h2Vi8/ISOJeRS3XUWE5DNmXacYU47mwoGILJVy8VrAQtQ9EGdthafLEWvQrqX3GthozI5+un5xOr2nTA/LbLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188259; c=relaxed/simple;
	bh=oqsz7oTqnMzJEsE0FYNgIT8mwUtotzkcTfbnB4dWr8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsAyIAk3cSXpf3aq0YpnExsaSzOtXRszqO0cUORaSWEu+6bp83v+UHzAtsmFGmD2/aAjloT8dJ9du9zFiyzyiEQMj5hhqWBvKyiJmq+Hs4znqFUqxBdXd4LUdbhrhsUnRDurpRHOtjxUmjuwY9e6FLxl8tCDS5F4ZPqc4cX0iUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+Ec+RO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481EAC3277B;
	Mon, 15 Apr 2024 13:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188259;
	bh=oqsz7oTqnMzJEsE0FYNgIT8mwUtotzkcTfbnB4dWr8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+Ec+RO+oORajHbuTgqpouzHzAr/d57OOkvi3B1R11x5j1lL8X+uCR4pIIuSsKcNv
	 2In1wwslzCaABBgELv2qfDN8xTmvwMzAkjmGSUusmh5/frgz2bl1MA31NDT0dg4wI1
	 J3MaJzY2eSFebiR0VYMVcPDK/MWrqjbs4lAQcwhelzDl5EVwN+nRgCOhoMDPMBcsWB
	 cuuQHReuEi4WQd4DqraBcQFcqE5+0sFrh3naazGWvyH+iCJ/tY3YqXXQAmOXDl8zlD
	 c83EPLFc/ckeJORQLHOIy/7sMvzkk10EehsACOS+vLSGt5zLSKA+yVyoqmSSULSVNg
	 2qBqaOEEyjh8w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwMWf-000000005C7-0Rph;
	Mon, 15 Apr 2024 15:37:37 +0200
Date: Mon, 15 Apr 2024 15:37:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Radoslaw Biernacki <biernacki@google.com>
Cc: =?utf-8?Q?=C5=81ukasz?= Majczak <lma@chromium.org>,
	Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
Message-ID: <Zh0toTnoGBkJwOq7@hovoldconsulting.com>
References: <20240405102436.3479210-1-lma@chromium.org>
 <ZhOccGFkTFkUkRUI@hovoldconsulting.com>
 <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
 <ZhVix-HJrqQbiPrB@hovoldconsulting.com>
 <CAE5UKNp3uS9cqDbQjcP3SbfxVi3wPFG4LtP6z=WU_V+M9x6LtQ@mail.gmail.com>
 <ZhzuoWgA88CeenMC@hovoldconsulting.com>
 <CAM4=RnLQRPmYDt_c+dpsia4WFZVA1vukXa35a0Uupu7jMZxtVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM4=RnLQRPmYDt_c+dpsia4WFZVA1vukXa35a0Uupu7jMZxtVQ@mail.gmail.com>

On Mon, Apr 15, 2024 at 02:26:42PM +0200, Radoslaw Biernacki wrote:
> On Mon, Apr 15, 2024 at 11:08 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Apr 11, 2024 at 04:23:27PM +0200, Łukasz Majczak wrote:
> > > > Sure, but what about other transactions that are initiated by the host
> > > > (e.g. SET_POWER)?
> > > >
> > > Somehow it is problematic only on reboot and works just fine on
> > > suspend/resume and
> > > set_power.
> > > I will dig more and try to find out what the difference is.
> >
> > Sounds like it may be related to the i2c_hid_set_power() on shutdown()
> > then as Kai-Heng pointed out.

> > Yes, if this turns out to be needed then there should be a comment
> > explaining why it is there (and currently also as the delays you used
> > seem specific for your particular platform).
> >
> > But hopefully you can find a generic solution to this.
> 
> Yes, we might need a more generic solution though it is not yet clear
> for us which would be the cleanest one.
> As I wrote in the reply to Kenny, the design back in the day was made
> to use events rather than
> level driven IO line, to drive the power state of the device.
> Consequence is we need to request
> a low power state before the kernel goes down as there is no guarantee
> the kernel will wake up soon
> (prevent battery power leak). This event/level logic problem (event
> design for level type problem).

Ok, and do I understand you correctly that it is indeed the SET_POWER
command on shutdown() that makes the device enter the sleep state and
which then needs an extra transaction on next boot to be woken up?

And that the firmware will not enter that low power state on its own
based on lack of activity as the current commit message suggests?

If so, then it seems a variant of this patch would be ok as long as the
commit message and a comment in the code explains the problem correctly.

Johan

