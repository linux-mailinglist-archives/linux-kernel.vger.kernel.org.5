Return-Path: <linux-kernel+bounces-13223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17382015A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EC41C21978
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741D914018;
	Fri, 29 Dec 2023 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnY3xoqQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6813AE4;
	Fri, 29 Dec 2023 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d2764c0f2so93686865e9.2;
        Fri, 29 Dec 2023 12:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703880799; x=1704485599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuoxDF1r2nXQAbQcgBHqu0ZaVi4hq5gTpR1NRgy3bRk=;
        b=CnY3xoqQTd6j6gghZLFa+ORoG3RUNA9dCfmQXTq0qFdWMfBL9vrVeWIaWzzN1FAd+k
         xxUvCpGctJIV6zGw2kn28I/y+4Wczo626+/Pqq9r0099/xi/5Q+F6zh8Pgo17Xcw4tsH
         LCHAcO31UvDbmkp9XHl2avqiw1Zxwh9biyte5g6UgK6bL3Rz8h4PsxRAwHzYZ6t31GM6
         +iYUlyr94u/1DGMbjk0obsVMxuyZRpPPd8XgUGyzcMGxTWv5QHN0Usc4iE7FXaE/+wYP
         3OJPesBL7encvodaNLCGWzdrSRAJpPtL4/Ipee1MnmunjhtZFJwUeFv4B/1aM7K/YXbw
         4c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703880799; x=1704485599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuoxDF1r2nXQAbQcgBHqu0ZaVi4hq5gTpR1NRgy3bRk=;
        b=Gnp268K6qCP3iqNsUT4mlgw4LkUMWRdBfF9fGuQoZr4lIM+aieOEUcVpUVx8BTh5aa
         bJDVIEUSxLsDLl9panQYH3dDjEPtCwyggn0FV8ILQA3+w0ZB35vqc6F0UOWlAntN2hPW
         Kgif7Wfqo+jxxTS6xxrTPNDtVpkZxUjoJngCMcD/iQkgT6OoJylNFi+t+KZ3gaXVnif1
         IN4jAwfdEqAUzq9ewh+yCr7drPzI4z5oA5IFba2BILO8Px3pnpY1F2w1GHmo0mzeyBim
         /QFmtluljoch4Qb6GFneTl8wXotNRjVxhTvZFK+3ufV8p4BOTIRrC018fFqfe2USTwIS
         qOdg==
X-Gm-Message-State: AOJu0Yya4oG4WZYoU1eYXD6OBIXi3AuFUTyw9RIGU72TrYS0VCn/FPY+
	WZrPrVFzqK3BC3f1AChUjQ4=
X-Google-Smtp-Source: AGHT+IGhZT3SpzaCP8PrEkt+zUiBWyWsLmIoMRdnakQbSPt+aGbmY3zJo+NRfT4mf+9pOFet90mBlQ==
X-Received: by 2002:a05:600c:1f12:b0:40d:7fd2:3bed with SMTP id bd18-20020a05600c1f1200b0040d7fd23bedmr346352wmb.104.1703880799433;
        Fri, 29 Dec 2023 12:13:19 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b0040d79907acasm2947493wms.26.2023.12.29.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 12:13:18 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 19308BE2DE0; Fri, 29 Dec 2023 21:13:18 +0100 (CET)
Date: Fri, 29 Dec 2023 21:13:18 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Sagar Biradar <sagar.biradar@microchip.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Hannes Reinecke <hare@suse.de>, scsi <linux-scsi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Gilbert Wu <gilbert.wu@microchip.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: scsi regression that after months is still not addressed and now
 bothering 6.1.y users, too
Message-ID: <ZY8oXge0QKYUkO1b@eldamar.lan>
References: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
 <2023112456-disinfect-undoing-b5ef@gregkh>
 <34c5b291-b69e-4592-bc9f-fc1b2ef5c5d7@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34c5b291-b69e-4592-bc9f-fc1b2ef5c5d7@leemhuis.info>

Hi all,

On Sat, Nov 25, 2023 at 08:10:35AM +0100, Thorsten Leemhuis wrote:
> On 24.11.23 17:25, Greg KH wrote:
> > On Tue, Nov 21, 2023 at 10:50:57AM +0100, Thorsten Leemhuis wrote:
> >> * @SCSI maintainers: could you please look into below please?
> >>
> >> * @Stable team: you might want to take a look as well and consider a
> >> revert in 6.1.y (yes, I know, those are normally avoided, but here it
> >> might make sense).
> >>
> >> Hi everyone!
> >>
> >> TLDR: I noticed a regression (Adaptec 71605z with aacraid sometimes
> >> hangs for a while) that was reported months ago already but is still not
> >> fixed. Not only that, it apparently more and more users run into this
> >> recently, as the culprit was recently integrated into 6.1.y; I wonder if
> >> it would be best to revert it there, unless a fix for mainline comes
> >> into reach soon.
> >>
> >> Details:
> >>
> >> Quite a few machines with Adaptec controllers seems to hang for a few
> >> tens of seconds to a few minutes before things start to work normally
> >> again for a while:
> >> https://bugzilla.kernel.org/show_bug.cgi?id=217599
> >>
> >> That problem is apparently caused by 9dc704dcc09eae ("scsi: aacraid:
> >> Reply queue mapping to CPUs based on IRQ affinity") [v6.4-rc7]. That
> >> commit despite a warning of mine to Sasha recently made it into 6.1.53
> >> -- and that way apparently recently reached more users recently, as
> >> quite a few joined that ticket.
> >[...]
> > I am loath to revert a stable patch that has been there for so long as
> > any upgrade will just cause the same bug to show back up. Why can't we
> > just revert it in Linus's tree now and I'll take that revert in the
> > stable trees as well?
> 
> FWIW, I know and in general agree with that strategy, that's why I
> normally wouldn't have brought a stable-only revert up for
> consideration. But this issue to me looked somewhat special and urgent
> for two and a half reasons: (1) that backport apparently made a lot more
> people suddenly hit the issue (2) there was also this data corruption
> aspect one of the reporters mentioned (not sure if that is real and/or
> if this might be just a 6.1.y thing). Furthermore for 6.1.y it was
> recently confirmed that reverting the change fixes things, while we iirc
> had no such confirmation for recent mainline kernels at that point. So
> it looked like it would take a while to get this sorted out in mainline.
> But it seems we finally might get closer to that now, so yeah, maybe
> it's not worth a stable revert.

If I'm not completely wrong, finally indeed the commit has been
reverted in mainline, with c5becf57dd56 ("Revert "scsi: aacraid: Reply
queue mapping to CPUs based on IRQ affinity"") .

This is what was mentioned here:
https://bugzilla.kernel.org/show_bug.cgi?id=217599#c52

So should/can it be reverted it now as well on the 6.1.y stable series
(and the others up as needed?)

#regzbot link: https://bugs.debian.org/1059624
#regzbot fixed-by: c5becf57dd56

Thorsten, hope I got the above right.

Regards,
Salvatore

