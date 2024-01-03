Return-Path: <linux-kernel+bounces-16004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941028236E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BE31C245D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478991D681;
	Wed,  3 Jan 2024 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d60WAT0g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7181D55C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d4a7f0c4dso102148725e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 13:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704316022; x=1704920822; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XopGBTIxwh37vdjMibvYLI8oJTlpwpMZAFmHsoe3mMQ=;
        b=d60WAT0gmtfFzQsFtKNQaM/U3NNPrN+UjZfs75DPiXpRh19ysEJocPh8ha9bnfvLRB
         kdWL091IQPvVUNvxFs0a+2+8jZVBOJrkZixzsOGtcXtXB+s5HonGUSyp2KhyXYiNJ146
         PoGFMlcxHDud61eMiQbHmviM12LcIbYnUc6Vgy/JmpcQzhFMcRfPek0B6l6E2tbOUNdj
         +XL2T5IrP5rI/DZ1lesr6u+uRPKa5Ir3WJKxzJhE2fIwMxIHKFd1s67p51kHhkdeeAVb
         fyVqo8oQ4gmSeg9/5JacIo7cnR+6LN13jv/E8YcFIfZSzaj3np2hwIy/3sXM61/CwMg9
         5vrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704316022; x=1704920822;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XopGBTIxwh37vdjMibvYLI8oJTlpwpMZAFmHsoe3mMQ=;
        b=Ez2O03upBXRRHXDxfUpWHf11+CAUrhFTtpPk1C2N1ZysRlaDElUW+PkzrAA0INPOju
         X+lOazkNQe+ADCEMxjhF3YXxfGPWM5A5zBX9gEqkRrQLjvrqiPaPf1ftl/CZX/EA5/oF
         QexrYW7LxKRKZNdWoEvEGK1VUIc8jKkVkyI+Ff0gM0MY9T6lewXMzUIrlZDQP7B8ykmk
         F6ZV921Fgrf+95G7o/zsXb3Zwv3GwWEHG6Bp0SizH6xf15mtj2/pKyiFEaXKOBrxp0CM
         WnOWM82oMesrTx27Bj7Gh716QV3AhHIA7KzZ5UdtG3dhzNZ37DckSdISUc8D6mvswyK1
         Jtrg==
X-Gm-Message-State: AOJu0YzQOjg47sj4ZMimbMpF5DzcrXIJDED2NdgmCq4FT6YL1hk3AgXn
	Ah5Ljwhv3zJSYhaZicMdhmHGnYzTKAhOZA==
X-Google-Smtp-Source: AGHT+IFXIzcZX+k44lLg3C/fTb+FV0k77refuR6e+ayuL/TfA6/NW/mvIU/5pQTTtSvctGLbRqBjPg==
X-Received: by 2002:a05:600c:3f97:b0:40d:899a:7cf7 with SMTP id fs23-20020a05600c3f9700b0040d899a7cf7mr2458006wmb.8.1704316022237;
        Wed, 03 Jan 2024 13:07:02 -0800 (PST)
Received: from ?IPV6:2001:8a0:6cc7:ad00:405d:cdcd:8747:287c? ([2001:8a0:6cc7:ad00:405d:cdcd:8747:287c])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b0040d8d023760sm3428415wmq.5.2024.01.03.13.07.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 13:07:01 -0800 (PST)
Message-ID: <49b058fb-4900-4c5d-8f63-db781408bd18@gmail.com>
Date: Wed, 3 Jan 2024 21:07:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Andr=C3=A9_Coelho?= <andrealbergaria@gmail.com>
Subject: argv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

How is argv contents..say "hello abc" is put into stack?

push "hell"

push"o ab"

push "c" ?!?!


thanks...

-- 
André Albergaria Coelho
andrealbergaria@gmail.com


