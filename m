Return-Path: <linux-kernel+bounces-67394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37EA856AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867921F23300
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FF8136675;
	Thu, 15 Feb 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpwOJCEF"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9197134CD2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017718; cv=none; b=i3W96lGig/QmTUSLldcH5IhTi4JF4UPsorGfEKLjNq7z1zkubZ3/D71hYWJDndrQVzxafg0IuxKysfVMsfya7U45F+ROlJdWM+H/VGTf/ijRhgKTJkTId2myOXXEQmwEBK01p9M41AbuvJpuJ9PslwtOLMzuRIgMc0NYUCbsb6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017718; c=relaxed/simple;
	bh=bPPhv6M1jVHZ4gzj64UEa5P7UgfjW1tD7WsDt4XqLJc=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=PZglPzGHqYV56rrqXzs6dUHl7llsA+oMAueOdw3W4v4tRfM8IYhu+/ThX5/uymSdAcv6Qwqh3nlQcBwfSdYwwNVuLUnI4/bM3R4z6v1UfzzB8g2r/BwlS2393EwYwi5jI9CxJTU3eA2xaCBoNL331ptkmVSlcBo1r4TBi3CGnO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpwOJCEF; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a36126ee41eso154749566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708017715; x=1708622515; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPPhv6M1jVHZ4gzj64UEa5P7UgfjW1tD7WsDt4XqLJc=;
        b=DpwOJCEFSZ4wAWBSwaPMVy+/kgVnIE3wRPMLcBlYsyvFjqbwuSxytu612w/FFNPgah
         n+lwP0B3FOBFjIhpsJIE5XmVBDKDFh413TrUCmuxaJE4EWjgiD9ta2ZCbiquqt/iZ5Fb
         k3y3pkMYEEKTo2+uLpxpq1E+1ov49M6pc7mLrq4iEk6O3T/sVbr5RFw9jZy2YplxHcyR
         8bCzNz7CTZQQiMzMUIhReoeB+tv7sDyvQsOfiY4T6iD4jg17O23SIMbN4BH3qB9WJu6d
         aSti/VL5vHSebdqwTRbgyJSlP+XdFTiO+DC5cN5py7xF/2aGBamkTqWDUuQBYYCNEgp1
         1eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017715; x=1708622515;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPPhv6M1jVHZ4gzj64UEa5P7UgfjW1tD7WsDt4XqLJc=;
        b=BEaHZUtWzAL/Srfrwxr0ui5yevdd0dKrY0cxfXuVJR//+7yRejg2fLwyrWbo3dZ0Gu
         BQsNrDcVkRwba892VbnU/THIKQ5DcJxspABn/3J2n1eP77vW2FssLE7IuWFPuJ85ztjI
         SNDD+ReffDMVsCPcUlvFsitL94dGdae9K8908man4R3z1uXqxXdGqwuYuJ1iX/lEYiGn
         4IPr2H9IKrLiQhTbJDNZtylJ/Yd74SQKkd+EgvrofiZYTsG16Btu01xpp0rneogeO7iL
         3SjSnwxgG8zrpxDtsKIBKUBO2rWDM6VAU2rMqH8zy97409zl7WbtKTDgIC+RJaW9+DLs
         sd2A==
X-Gm-Message-State: AOJu0YxFhtdmtVOE1ZM7kT1k/03YqQe+26f1d2QeUJYkKBGbfWPONreV
	UKbAfPgmh/w4nY1GAkz5rbEPzHq80XsyNoBsfmdM9joPdIC4Gbvplg8AOtgfyOg=
X-Google-Smtp-Source: AGHT+IFD8XMWfBO/Jnl9bZZA94RTPVrDEgWrgG8HD46DYLpX+xI7JXZJAfBRUSQMpWTjEKCSJBZDpQ==
X-Received: by 2002:a17:906:a19a:b0:a3d:2a52:380f with SMTP id s26-20020a170906a19a00b00a3d2a52380fmr1684965ejy.72.1708017714772;
        Thu, 15 Feb 2024 09:21:54 -0800 (PST)
Received: from [185.222.58.100] ([185.222.58.100])
        by smtp.gmail.com with ESMTPSA id gz15-20020a170906f2cf00b00a38103ab710sm756987ejb.125.2024.02.15.09.21.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:21:54 -0800 (PST)
From: Sarenaa Fuller <aashisahu8126280732@gmail.com>
X-Google-Original-From: Sarenaa Fuller <castillom551@outlook.com>
Message-ID: <200f12c0523e9570dddaf79f2008382bbb687850f0624bd6728fd2a6f1f9e201@mx.google.com>
Reply-To: sarenaa.fuller@outlook.com
To: linux-kernel@vger.kernel.org
Subject: Acoustic Instrument
Date: Thu, 15 Feb 2024 18:21:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I'm offering my late husband's Yamaha Baby Grand Piano to any passionate music enthusiast. Please inform me if you are interested or know someone who would appreciate having this instrument.

Thanks,
Sarenaa Fuller

