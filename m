Return-Path: <linux-kernel+bounces-23238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6AC82A94C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E18A287BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F42CFBFF;
	Thu, 11 Jan 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8Z8BeqV"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AA4F512;
	Thu, 11 Jan 2024 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28db7135547so1143328a91.3;
        Thu, 11 Jan 2024 00:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704962731; x=1705567531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0p2QvXbb6tDBiqGiEYeQcbEA1zFe8DGnARuboQIRWQ=;
        b=I8Z8BeqVN0CsmoW+rh5JAaNOTzOWtj5pFBJxtpKGva8Os7jQjn6OEmVZeSI/7g1Ls6
         mLMvLXOww0p+fDtocA8LUaQsFyFUX9PksJd744QM0YlFCPplhbll6IeWqs6iP7NheUDj
         Kl9d2hHdddHgY4LtKR3FD996EYAWWl4yHm/uFBdjyo9n8GKealASuLN4FYx8spsQm2Pn
         F9PKWOq4DuSD/Eue1/h0QVGD2Gw9YmBSfMMVaofsdnm7k84rpsKf4YmHEGoQ/4wvOtxq
         R1TbLxH9OwCrt0O+pF9qgw6NKxJUGq9cEgtzHFlgDe+5SPb+Ln2NPteo6mMx4z/2XLaJ
         FaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704962731; x=1705567531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o0p2QvXbb6tDBiqGiEYeQcbEA1zFe8DGnARuboQIRWQ=;
        b=gf6Fc4fUxW6stNtcTeUEVrSfZo8WY5KIGBniDvWF1cI6IwJo/7fdUhHyk2q1k/itmy
         uoKaBkUcM1vN6q3Cb85fhRkI+HR1+W15aozA4XOehJVf6udx0Cv4yQLurFiavmpNwUN5
         +jewXPpquuCdAnIHji7KO76MMlVKGvNM5Xa+MYQY6cxAVLc5ocB07w9KhKclAvTY7YZt
         Dpxbt/lDItTx9lzRKHprRZWExJzbQtXBx/iba2Ewx8Uq4OQZb5juk9aellHuvZj+xFZC
         JjoVX4A8zVgqGQsd1NX0gH9B73Lf1h1VGbCOU5VE6hqzlKw9qreDjE2WNE3l6hpnaX01
         SDdA==
X-Gm-Message-State: AOJu0YxFKXz6ux0AnC0OiFOTGATExe0wHQuIo3PewEENfmdGDEJ81SON
	BHVge2JlD+WFz5Jxh8rUatk=
X-Google-Smtp-Source: AGHT+IFSKRaN+Xehr82emaK7CxkU7c4WmpLWseYDLDbxEDV12WXUj9cAPg2gKXkUwbUsQat5ZSzOZA==
X-Received: by 2002:a17:90b:1fcf:b0:28c:e9ed:f724 with SMTP id st15-20020a17090b1fcf00b0028ce9edf724mr591054pjb.98.1704962731648;
        Thu, 11 Jan 2024 00:45:31 -0800 (PST)
Received: from [10.193.226.49] ([106.39.42.235])
        by smtp.gmail.com with ESMTPSA id mf15-20020a17090b184f00b0028cef2025ddsm850818pjb.15.2024.01.11.00.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 00:45:30 -0800 (PST)
Message-ID: <ffb39127-a462-4ce2-be37-cba8a36c8064@gmail.com>
Date: Thu, 11 Jan 2024 16:45:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: Fix atomicity violation in
 {min,max}_key_size_set
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@outlook.com, stable@vger.kernel.org
References: <20231222151241.4331-1-2045gemini@gmail.com>
From: Gui-Dong Han <2045gemini@gmail.com>
In-Reply-To: <20231222151241.4331-1-2045gemini@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear All, I hope this message finds you well. Following up on my 
previous email regarding the patch, I want to highlight an important 
aspect. In /net/bluetooth/hci_debugfs.c, there are four similar bugs 
related to atomicity violations, potentially leading to minimum values 
exceeding maximum ones. 
https://patchwork.kernel.org/project/bluetooth/patch/20231222162931.6553-1-2045gemini@gmail.com/ 
https://patchwork.kernel.org/project/bluetooth/patch/20231222162310.6461-1-2045gemini@gmail.com/ 
https://patchwork.kernel.org/project/bluetooth/patch/20231222161317.6255-1-2045gemini@gmail.com/ 
https://patchwork.kernel.org/project/bluetooth/patch/20231222151241.4331-1-2045gemini@gmail.com/ 
I kindly request your review of these issues alongside the original 
patch. Understanding your busy schedules, your prompt attention to this 
consolidated review would be greatly appreciated. Thank you for your 
time and consideration. Best regards, Han

