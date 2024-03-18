Return-Path: <linux-kernel+bounces-105843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F85487E54E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30C82810EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED4028DD0;
	Mon, 18 Mar 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="Tjd4qlfo"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315028DA6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710752193; cv=none; b=mZq0pG20a3C+FUP0UMChYPSjGp4w912/KpT2uz83DK2JMfYB2gokYCZATZdUaK5PVRmJ3H2bRGTyZJWILqv3f6Q1bnTKArMkweQ7aW2blN63llVQRSmqKJ6/OJ+izzOtYFN3jmjwli3y8aHYSO3CZSsun2PhxgDNmbrONbVz87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710752193; c=relaxed/simple;
	bh=IUxyGsX+0g8qtVhRW6OTzDPIK36B3p40MM9Un1H/vHk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nsUPkuFTC5IIQOF9//F1B2DMLnuVBp9YM3vp3gvFI796dcCj3mZ0acag3hMYiRtcE/Gw757ifeasLuFkNwcT5l4ZzySuur95vLvq6jFd2WNC7qiAmMmWdWIBRUu9IPBI538qrbTYGvu6S9xA6AIuyMWeAaxJpGUG+FxhkzxZUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=Tjd4qlfo; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e6888358dfso487503a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1710752190; x=1711356990; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNVmnw5toWb8ERcsPGfVr3oGNxB/ZS9svnfOKz1b0WI=;
        b=Tjd4qlfodI0hl+OoCjIDVThsPdaPgDbkH8QXRq37NnhvXwxutPiVm5C4+A3L64bmC9
         BytNIYJoVncNN3343Fj+WAU0hgnzZQAn++WvRoALsxvxNzqqxvXO7fb41u6hVQmSZPr/
         fmh+vUS95ysY98PsrYPW8+wiRdiYmucEoeJIGsJZRkvupaTNrQWiumbJnKeTxTlXx8Te
         eXpcA1in4cfNgX+gFmyGkGBDMOUF2tyzN6c4VCujWiEyZznlC7E5P32InQIKak8/PQJ0
         JU2n6ACJwzJK8eqJcG/KFyFmgwJmdVCfSF2te3RGrKkpCT0n37Vza+EtOuC53xtPexVi
         hnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710752190; x=1711356990;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNVmnw5toWb8ERcsPGfVr3oGNxB/ZS9svnfOKz1b0WI=;
        b=OlMK674nUfpIdUVRKU3zMgV8+fEGXbvdgWXzypYqbQmvUGpnufblBPK3r6oBeS+ibi
         scPHCotMKaiw3nGGZQ1GHcx6K/3ggo2062l6Zwarrj+Pv2Xsia7I3VoJnnyyaX1ihYwW
         c1XObubZCqV4nC4SRO9vW6wQDw2XhdX10CBfAigsA9+vspEyhVh9QdF17MnfETdgIsE7
         j4ClZFSGvXWDwGDRK9SEh2v0tCtwX+nE8O1wG7Bj7cUCTtxrgOadm7kn4L0OkvpI61Of
         +r9qq3FmQwraW4GAKCR5ewUXc/+r+t5M3nEbBzKS8j2+2Qo7cbRcXASLriM/1EkEuAl8
         tYHA==
X-Forwarded-Encrypted: i=1; AJvYcCW+D4mZs2VG45PKf6jtQ6HtbfPZ5xzFZoDa+0QInaGagjdf8fWSeBU4iqy3sj1qV4s4bgd62Tkr4u07vliGZLcN5YUwtDmxP6QOioJw
X-Gm-Message-State: AOJu0Yz5j9DEqsucBLabqN80mAbUtPbq4yw1qZ9Y8XqUyCjNsnlLRFkm
	3L8S9rUBSooC2u45TXfXbc4a95ze9saWIXJLJvqRztjeQBe0mxa1pm9Cdz848GY=
X-Google-Smtp-Source: AGHT+IEdO/tHuBAkjt3y9oKQtxXQsLM0K+r5V5CdjrWyRPB3aidDD7XCyC+3s4Gpea/J8A7N65zmIQ==
X-Received: by 2002:a05:6830:168d:b0:6e5:390:5b44 with SMTP id k13-20020a056830168d00b006e503905b44mr13391333otr.30.1710752189570;
        Mon, 18 Mar 2024 01:56:29 -0700 (PDT)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id d15-20020a631d0f000000b005e4666261besm6667101pgd.50.2024.03.18.01.56.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2024 01:56:29 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v2 2/2] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
From: Li Feng <fengli@smartx.com>
In-Reply-To: <096362ad-174e-4939-8296-e0d11f83a120@grimberg.me>
Date: Mon, 18 Mar 2024 16:56:35 +0800
Cc: Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Anton Gavriliuk <Anton.Gavriliuk@hpe.ua>
Content-Transfer-Encoding: 7bit
Message-Id: <9E577C75-AEF2-4C22-8B85-4BCE8E2B65A5@smartx.com>
References: <20240313123816.625115-1-fengli@smartx.com>
 <20240313123816.625115-2-fengli@smartx.com>
 <096362ad-174e-4939-8296-e0d11f83a120@grimberg.me>
To: Sagi Grimberg <sagi@grimberg.me>
X-Mailer: Apple Mail (2.3774.100.2.1.4)



> On Mar 17, 2024, at 15:31, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Does this get you the functionality you want Li?

Yes, it meets my performance needs.


