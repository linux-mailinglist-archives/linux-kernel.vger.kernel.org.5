Return-Path: <linux-kernel+bounces-13447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3045C8206B5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34461F21591
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75428F59;
	Sat, 30 Dec 2023 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4V9C77n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0DB642;
	Sat, 30 Dec 2023 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67fa018c116so44140686d6.3;
        Sat, 30 Dec 2023 06:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703945671; x=1704550471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcI8rtnO2DHiVZkR5J3yMIc49aRf9YUpVyZK2ry/OBk=;
        b=m4V9C77nHpH0l3dG47aOuvtAkZT8mkVOg6M742vIP4BrTumaat/dHJycWm0JqTWaO2
         163i/dEnQaZPxYYaAeIoqpf34poZP4JeG7suRsKummK1YrFbUeH9C9ANSkIzcGPyQAPg
         rGzDW4lWF8zW24QBSToFudMydG8kwLbB9a82dEJ1NwPBfv+f+lTx1gNTUWbBlVdAY9FE
         avsJFboQXFjtD8/dhlZe4Zj+MdMdUH4IRnmiWFNQkNIb25XlOjJW+WXvpYWEDc/ht1tQ
         T7saUrTFlY/TaJPCAGWmWl+4xedxxxNA7sXPGT8Ctt8Bcx1VJkW2cfsZkS0slUTwokSC
         1k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703945671; x=1704550471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcI8rtnO2DHiVZkR5J3yMIc49aRf9YUpVyZK2ry/OBk=;
        b=xDbZEzvR4nzm+K/t5c9OHE0SVRCKaS0fk4zV1721xU0KieXB6Vl2dDSOs5Hc1RsXBN
         MIDQEY8n4oZS+efrwWMZKD67tfxGVFnQH995FSbB2Tx70D7WSlSbmMMZlEC6xPuDPIS/
         7YhPLgQ5WKeddeN/g/67wyCSuWabHSPvEWkjZlX4oumT0W1qOMee0pRiXDqu6omjaSjT
         9IkOKIK9wJSkelShmq8dGURSGE/LkMN/vVEb5l4pTJsMBfcNn3qp0kgZu+dK9XxI4B4G
         q/gBJlgNeT20OkQaUkwMhhF1RJ7MWoEI+3j8fggB15OjDSJxyLIhfc3RcazdqWbxaHU4
         X+WA==
X-Gm-Message-State: AOJu0Yx3o4UcTGkdeioQLDR8lKeAZOB5+TWeFDF93qjhj5117/OoxL4n
	qrAH9p+blLRU9ZCVpWykkzer9fZ+q+p7BPsaJcYPl66MiWU=
X-Google-Smtp-Source: AGHT+IGvH4Zqw0uOFIcVVR+Te/cPb4vC9coHRn2BESa8IgsVLKG+Ltm3pAUsRomrOrcVISwi+eT0Ps4MHDjKGlMrVE0=
X-Received: by 2002:a05:6214:4b84:b0:680:5f49:6912 with SMTP id
 qf4-20020a0562144b8400b006805f496912mr5223461qvb.118.1703945671025; Sat, 30
 Dec 2023 06:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK2bqVKCdaD6-PZi6gXhf=9CiKGhxQM_UHyKV_onzDPnhbAmvw@mail.gmail.com>
 <ZY7omD5OBLUg6pyx@duo.ucw.cz> <CAK2bqVLBZvU2fVfY4bkFrU=4X+W4O3f5pbTdeQjMW=W2sGWpeQ@mail.gmail.com>
 <20231229172823.GC148343@mit.edu>
In-Reply-To: <20231229172823.GC148343@mit.edu>
From: Chris Rankin <rankincj@gmail.com>
Date: Sat, 30 Dec 2023 14:14:20 +0000
Message-ID: <CAK2bqVJ-odOQP6jHQJr6Xuyiw26C3RLzuFJt0NbANDY=0sO3qA@mail.gmail.com>
Subject: Re: Does Linux still support UP?
To: netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Yes, the bright spots are my phone's flash. But I did check the images
to ensure that their information was still legible before posting
them.

Image resolution is 4128x2322, which should be more than adequate for
zooming in.

On Fri, 29 Dec 2023 at 17:28, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Dec 29, 2023 at 04:03:56PM +0000, Chris Rankin wrote:
> >
> > I have already attached as much information as I am *ever* likely to
> > be able to extract about this problem to the Bugzilla ticket.
>
> In addition to doing a bisection, something else you might want to
> try, since in the bugzilla you have hypothesized that it might be a
> bug in the e100 driver, is to try building a kernel without the driver
> configured, and see if that makes the kernel not hang.  If it does,
> then it's likely that the problem is either in the e100 driver, or
> maybe somewhere in the networking stack --- although in that case it's
> more likely someone else would have noticed.
>
> Something else you might try is to connect up a serial console, so you
> can get the full output from sysrq output.  The other advantage of
> using a serial console is people are much more likely to scan a text
> file with the consoles, as opposed to downloading and trying to make
> sense of the screen snapshots.  (BTW, was the flash enabled on your
> cell phone?  The bright white spot in the middle of the screen makes
> it very hard to read.)
>
> I'd also try sysrq-l (show backtrace for all active CPU's), so you can
> see where the kernel is actually hanging.
>
> For better or for worse, support for old hardware is a volunteer
> effort, so owners of the said old hardware need to do a bunch of the
> leg work.  Or if you can have a paid support contract, maybe you can
> pay someone to gather the detail, but when you say "is feature X
> supported" in an open source project, that has a different meaning
> from a commercial software product.
>
>                                                 - Ted

