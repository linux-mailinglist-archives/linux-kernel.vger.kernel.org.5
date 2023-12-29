Return-Path: <linux-kernel+bounces-12970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6700C81FDCD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1C91C20DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB516AA8;
	Fri, 29 Dec 2023 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKV44YdX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC20568F;
	Fri, 29 Dec 2023 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9af1f12d5so3378967b3a.3;
        Thu, 28 Dec 2023 23:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703835784; x=1704440584; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DSZUFKqdAkWuN/kPVFG1g+yNtSLVGaxATVMRCqbLdNs=;
        b=jKV44YdXFPx1uMBe5JyXFF5LECn8O9/QwRrDHJqhVtsKujOz/PAEaKevt7r/+YI1It
         G8FHeROxWs4rMnmP5wjeFs2hlKNDa8pKontRu1xCNbHZmVB7IyMMR8TA6KBKIRrymt2g
         wYVJd22+/v+GmicR1s+PRzcMv3LMimuqn9uOliuEHn1o5IuPENTLD2crXOBW06PRsmc3
         r0Xs/5XqkJy8o2qoS3HRR7MYdoTZPYFvb7RgxNDrfYPdeZ7Y2526NE0DriLrcHYRzDW8
         9OX5IA2O7k3x5GSKEGTgyHDIRbFeZVL0l//B7u9pS6q9HAsNKNIP/1gnyyCBRSOXff0S
         5d7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703835784; x=1704440584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSZUFKqdAkWuN/kPVFG1g+yNtSLVGaxATVMRCqbLdNs=;
        b=dnGklOZDq3qkC9GwlA3d/gWkN4ot9cEAKdSjlWgKzBBTf4ckWV1WGawCvle3oeGkzi
         DHbza0KOjkJ1XX0JQsmvzMyoVmi9HaqwIWtAz3ebjrhxTGzBANsF5BWNGVi0Pqxkd1M2
         GqFpu7nj99QqzYJW/5W+NOfFM3NjjlE+fDRjar2d7AKcv7mXxZEOgV84tvFVhJiT7+PT
         9B73nYRvyebOrrUaNxDrwE4NnWHA6VQ7cJkvvJCBx7/7Av7gFkAQMNx9pov65m9zDw8g
         9rwgURvPI55QXNGtEk7hbFuWZukjoV8IW/CJ06VK/C1HCEamJvwjr+NrjA0yCfrC4ZfS
         VhqA==
X-Gm-Message-State: AOJu0YzXLAqARmItK12B6P+YfY9pCqFF3MV7NEb7QwdnA9lVpuZ/J7OY
	SH2TY2Vcc4JyeVRsDjHLWgc=
X-Google-Smtp-Source: AGHT+IFM5AhGPzADe3gnfyREyBN6MsiZZESq7UvdeK1e3fzi201YAGnN2BZOARv04MvoLPghgBh3Kg==
X-Received: by 2002:a05:6a20:9388:b0:196:60d8:187e with SMTP id x8-20020a056a20938800b0019660d8187emr1962378pzh.57.1703835783844;
        Thu, 28 Dec 2023 23:43:03 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:1995:632f:ef1e:946e])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a638300b0028c8149ac6esm6148076pjj.42.2023.12.28.23.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 23:43:03 -0800 (PST)
Date: Thu, 28 Dec 2023 23:43:01 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Henrik Rydberg <rydberg@bitmath.org>,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH] Input: MT - Return directly after a failed kzalloc() in
 input_mt_init_slots()
Message-ID: <ZY54hX3VLswwKgMH@google.com>
References: <5088a905-4f29-41d3-a96e-5b66aad551f1@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5088a905-4f29-41d3-a96e-5b66aad551f1@web.de>

On Tue, Dec 26, 2023 at 08:43:37PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 26 Dec 2023 20:36:09 +0100
> 
> The kfree() function was called in one case by
> the input_mt_init_slots() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> Thus return directly after a call of the function “kzalloc” failed
> at the beginning.

This is not needed. The same arguments as on the patch to
usbtouchscreen.c.

Thanks.

-- 
Dmitry

