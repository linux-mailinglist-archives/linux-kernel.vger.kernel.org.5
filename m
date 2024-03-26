Return-Path: <linux-kernel+bounces-119613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CD588CB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008FAB283C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E811F61C;
	Tue, 26 Mar 2024 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYAVfZfx"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7211D543;
	Tue, 26 Mar 2024 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474602; cv=none; b=SmKGXMkCPysFi3Qp6kxkWdCCF0Vzx2tuEgSTv+vgcsgOtUJOC5LkdIqNREyY/8VVhiQZLhVPsL6nDW3/LYP3GR83ylIDjSmyIk5FW1Ioq//R73J1CGgekYMEmL+P06YGdJ7xQ4noMJ95eZk8oVh6nl+/9GG4KrUfnSAUb3kBvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474602; c=relaxed/simple;
	bh=/rinlx2R00TvSZazfOcwJxxjtBKFFFN7uLVG+OJZ22s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqqbYSxy7NEa0UAul4oznXNUu8l4qt6va4T/75QLcsSN+vD1NGIdJi3jJ/rqW6VsiqT/nfSQ8QIptJLafOER/6Qow7IQ2KBUa9hA3X+ZbarNqROJuXXUocn+2nj8AEmk/kvq9USfqNv23e/GRFjL/gUc2dco+1zlPqx8zTDU24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYAVfZfx; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d28051376eso106742871fa.0;
        Tue, 26 Mar 2024 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711474599; x=1712079399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbTXGmg2c984TeMF7UUYAPuchkx8RKHs1yRN1ekmxDo=;
        b=GYAVfZfxvZw4WE36Mla1aLYI3Jm17X15lnORFe1nxBtcGx5GGFFS2cp5J/9zDvlkiR
         aqu4ugHKr3n+aytLMwsQaoZD9xl8NEnVexQRf5bwfg4LWW+NP8dJ9PL7flShvaeHfHW4
         sdWu5/dVw2sYhHBIRM5l2Zlg0dSMRpukEk3V9bxJwu5KTXscMPEymMvJCQVZQBvFjFZE
         nZU1Cg8ZTVwGe+p5Yr69M6Ug7Z5roOP+SqO0GUaV84HzwOSXvdYiZkOs3IOCGW5kBfpY
         +VOX5+OBtPxKcznvH8AVTFCQ1vFiXczzYwBJeZhXRd9/oZan4YAS+WzfIunnlPVPsBeX
         LIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474599; x=1712079399;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbTXGmg2c984TeMF7UUYAPuchkx8RKHs1yRN1ekmxDo=;
        b=w8weAUP1HuUmY5hks1AD8KxMRagK6xDRJyMdP1V4uJq8cgxvcKqcQDnmqyQ9qMvaic
         xLV7oADGE+UEPMIYWA6xzMSLpNIcZp0P2HMTR0Gwghyp5qemq7+Y2ENKQPqEGbf9KxEN
         64l+gGU263JMMnD7LmAkH/BDHXW9vMW6Bx+aJnRM1ShPd7W044E3Hl3hubApsBFQW2Kh
         w7eNC/0UxUl4cN4gue9GyJEI+QAWSaWoHzNpnUnVQJrOhRorN+uq1DS8l5lhCWRXv3qz
         oetfOL3rHnV++rNugDtMLsXgP3DGV9O37xrjM91HplbcfuYUGlBxREmjcmAVAApFd89j
         9JJA==
X-Forwarded-Encrypted: i=1; AJvYcCVWe0xDPWowgM2C6//+9Z5dZlolJgzu9r7f2W+Wl0wmPgaCEkrVbFR14L73Ev7576/IhhGnQ9PF77RXlOUOsGkw1seXjoIQm5jzuPnQIrs4iYpASbIhGBXH7CE4X7Xq4DxsKNz9jxBipw==
X-Gm-Message-State: AOJu0Ywn23X4zj2W4uVykIjjYQWqOlJLOG/XdEAYcrPydpJdTu65Hl7Q
	OWuKG2teyskxyS6hsX0o9sw4V3iH7W1PWQ2aLlpvbYuHA0ZVJ4Ju
X-Google-Smtp-Source: AGHT+IHVTUFg0i7UzDQ4ho8db2VdQCya42bQjZRPiTTxG4XO2YZ41SsSWfxpcC7bp/76n81ItscnCQ==
X-Received: by 2002:a2e:964c:0:b0:2d4:3e96:47ee with SMTP id z12-20020a2e964c000000b002d43e9647eemr306245ljh.26.1711474598855;
        Tue, 26 Mar 2024 10:36:38 -0700 (PDT)
Received: from chinchilla (92-109-110-130.cable.dynamic.v4.ziggo.nl. [92.109.110.130])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709060be200b00a45f2dc6795sm4443958ejg.137.2024.03.26.10.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:36:38 -0700 (PDT)
Date: Tue, 26 Mar 2024 18:36:36 +0100
From: Matthijs van Duin <matthijsvanduin@gmail.com>
To: Andrew Davis <afd@ti.com>
Cc: Robert Nelson <robertcnelson@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Kridner <jkridner@beagleboard.org>,
	Drew Fustini <drew@beagleboard.org>,
	Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
Message-ID: <ZgMHpK5KXdalX-cj@chinchilla>
Mail-Followup-To: Andrew Davis <afd@ti.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Kridner <jkridner@beagleboard.org>,
	Drew Fustini <drew@beagleboard.org>,
	Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240325210045.153827-1-afd@ti.com>
 <2024032631-excursion-opposing-be36@gregkh>
 <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
 <c2125144-659e-42f2-af1f-ffef7ec3d157@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2125144-659e-42f2-af1f-ffef7ec3d157@ti.com>

On Tue, Mar 26, 2024 at 12:02:09PM -0500, Andrew Davis wrote:
> These users rely on out-of-tree patches to make this driver usable[0].
> In its current state upstream, this driver is not used/usable.

These patches are to add support for newer PRU-ICSS(G) found on AM335x
and later SoCs.  Presumably the mainline driver still works fine as-is
for the original PRUSS for which it was written.

-- 
Matthijs van Duin

