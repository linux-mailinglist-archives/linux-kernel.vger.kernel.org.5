Return-Path: <linux-kernel+bounces-17453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECF4824D70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C348E1F228E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C424C9F;
	Fri,  5 Jan 2024 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VStoL04s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB44405;
	Fri,  5 Jan 2024 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so127608a12.1;
        Thu, 04 Jan 2024 19:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704425284; x=1705030084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KR8vLsD9bZDkCb0zj7kqJDNeQ83Zsylg5eIJGKfIYAQ=;
        b=VStoL04s3tynXmUX8QmJFqxG3t0IXBvkBTcofLTwfCi7m0SgI54hXY4U+tr2nP1dSh
         G0kdpdvpU/pjarZhpH170wuEWkrNiT7ljB//9oKpFBxg51khU+PvEs3mw14W5mnOB7Qc
         YHTLACYDJffTYlLek2pJBQkvwCrvomb/7K7lMRRwoeOVYrZH/CDaM0mjKKyZGIgCubZO
         fkP/M4dSkvHiQ2CyZ9wJJVUtppsiarT1wff40lrprvzbPbX1fH2whlJVm2jRqoauoXUi
         0oqlLpkH8L4R9xlGcwpSN8WJcM+m5DiZgysUxaPPsYcwqIKjjpyMAFBJOL66ijNX/3iY
         9t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704425284; x=1705030084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KR8vLsD9bZDkCb0zj7kqJDNeQ83Zsylg5eIJGKfIYAQ=;
        b=BIpvZcrxbu/jOR8rXfGiVSbYEApaWJKhySe+6KsFGI/PB7dFKoHVsA2W8923Jq5DE2
         9TfAfTGTGkIFD6Zj6fhuy+fB03fMUwGia2G/nViEVVBJVP1I1MG51bRPPSHvJgXkTMjN
         tFes8nXqtYwFkWONpLq200lhidfXAcRrqgoxQIsG46QAQqjdTojuCD3VYHScSbmnYaqB
         jDuL3TAnAVHXV43soGwmfNFQ18Pi6DDe0m8w0uTNOpCzXzmwUJ3Ttiatgubyx3Mw89Hn
         iSHfiITJDGCuSzRM0gc6yYv1O4i6vDGhpsoZHipoAOKKawjIrIBiqF/7WlPFsqBTFrT/
         XbtA==
X-Gm-Message-State: AOJu0YxCajGwRYwmIu6oWmV2OrHwt0DwPq5/yQzIq0KIX6YZxTG+4+yS
	PhxbxcW0rTeV+ipsWDp/ysQ=
X-Google-Smtp-Source: AGHT+IFA9RA7WddOR/qKx+TbW7rnH2QuQEnEG5MpkTVlvZ/M2k30OhnOKHLVZVeyqpXUqEEr7eG7ew==
X-Received: by 2002:a05:6a20:1605:b0:199:1ddb:b42 with SMTP id l5-20020a056a20160500b001991ddb0b42mr1771362pzj.11.1704425284559;
        Thu, 04 Jan 2024 19:28:04 -0800 (PST)
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q24-20020a63e218000000b005cdfb0a11e1sm384250pgh.88.2024.01.04.19.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 19:28:04 -0800 (PST)
Message-ID: <e57099de-f530-43a7-b9b2-bed295e13138@gmail.com>
Date: Fri, 5 Jan 2024 00:27:59 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: sync: `CondVar` rename "wait_list" to
 "wait_queue_head"
Content-Language: en-US
To: Charalampos Mitrodimas <charmitro@posteo.net>, ojeda@kernel.org,
 alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 aliceryhl@google.com, a.hindborg@samsung.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240105012930.1426214-1-charmitro@posteo.net>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240105012930.1426214-1-charmitro@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/24 22:29, Charalampos Mitrodimas wrote:
> Fields named "wait_list" usually are of type "struct list_head". To
> avoid confusion and because it is of type
> "Opaque<bindings::wait_queue_head>" we are renaming "wait_list" to
> "wait_queue_head".
> 
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

