Return-Path: <linux-kernel+bounces-14422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF50821CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB46C1C220F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10549FC17;
	Tue,  2 Jan 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MRV2LplK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3FFC0B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD25C433C7;
	Tue,  2 Jan 2024 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704202501;
	bh=Ibk8sEOGH1gE85+6yGGE3w/Leiem7H6nu9lxyv2HE+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRV2LplKk9Axo7cZAsrgqjdS5INN7OyvKVF+P6opgkLnRNhjExily3q1EQ09tnbxG
	 M2GumwlVoWifzu85wr8fz5KYgDwApkbzr3XYaLIDFRah1AzsbYbXQa4fv+9t7FI+V9
	 gBLW5gHgd4xjJuoXJBMNNpXPR7cokY0L3xxTS8q8=
Date: Tue, 2 Jan 2024 14:34:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: fthain@linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] nubus: make nubus_bus_type static and constant
Message-ID: <2024010254-truce-populate-70d1@gregkh>
References: <2023121940-enlarged-editor-c9a8@gregkh>
 <CAMuHMdWHnfwcdXrD6JrcdfxEop1oeMyN3hrvf+iEJQi-xM7pmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWHnfwcdXrD6JrcdfxEop1oeMyN3hrvf+iEJQi-xM7pmw@mail.gmail.com>

On Tue, Jan 02, 2024 at 09:16:23AM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 19, 2023 at 4:48 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the nubus_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> >
> > It's also never used outside of drivers/nubus/bus.c so make it static
> > and don't export it as no one is using it.
> >
> > Cc: Finn Thain <fthain@linux-m68k.org>
> > Cc: linux-m68k@lists.linux-m68k.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue in the m68k for-v6.8 branch.

Thanks!

