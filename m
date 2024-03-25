Return-Path: <linux-kernel+bounces-116650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8393788A1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A9D1C3865D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EDC136653;
	Mon, 25 Mar 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efkfqzff"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2B86140;
	Mon, 25 Mar 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351997; cv=none; b=r0QDxES/TzcGEGdZm7SL8h+7r+7wtzhf1AskmYH5xbI65ZNtVRHbs0DW8m7HlSRv7aGqJTgc10W6mu6juPrpx8cnD9qJ14ISRl5AxqOOOKnymPCG2pdE9kzv8i0qLOcMPYNuXX6Z1h+YbUH6u3wq15SRr2B2kgwVEHrMHWMYRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351997; c=relaxed/simple;
	bh=ekb1jmr1yhblLbCaXw9kmFVcNG95LhtHD4bhX7cojA8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dHf1DjhP2YyVuUmTCGyUCAENuJn9uk7S/iVGxqHiMeXV0V8Vk0pmrYYuuZrPKZlqIBErIv6hXQUl5Fs20e+Q+S89slZh5IMUbKS483Ya7Joj+DOT3a28nzzhgqa4R+BDYO/Rk1xJejq3qtNGaBdKgeFmKquH5WRTsepB4eiQ6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efkfqzff; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6aaa2f02cso2356527b3a.2;
        Mon, 25 Mar 2024 00:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711351995; x=1711956795; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ekb1jmr1yhblLbCaXw9kmFVcNG95LhtHD4bhX7cojA8=;
        b=efkfqzff1wljbKH8fhC2FL/LgAmxWb+nSzz6r6KK7dK2vJuOS2IDMjZo6oGj+OHWqM
         Aae/rlN+zJFrgJxuCP7KFVPDXBXQ6g3dW/G5lwV1AZVbQoDj98jZFkT/ReRQlNbJZ0vL
         NQTMRQOQFn46wfkjbCgBbOQwTghvyA373s73FvsTpjIdfTHohRynL2niOPCgtlqxh7pd
         FPtaVDq8Kt1s8Tnrq+NptqzwE+SHyyo8yrhWcKZNlH4iPboa9uJXsPrVz6hRt45pwjXy
         wQeAjdUR2b1qA5JRWUBuavNjkl0y6skMdJ/2Ex96hcNTB+R1hjmYYwGvU4Si8qyaaxIo
         ewwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711351995; x=1711956795;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekb1jmr1yhblLbCaXw9kmFVcNG95LhtHD4bhX7cojA8=;
        b=TeppEb53zsW+kSGe0R+vly7PklvWpLlmIGl0ihD9yj2PCIQtL/TbCdBaqKHvC4pZqQ
         PcAy3NzN4yJGEm6wFkgMhSdVWSqmFCI+6Lr7QDYJ3ecE8aJTiGCbDTcbSPErbnvMJWiI
         2N4VBdayZ2DQTTg+K8sWOpiwte24Qsj0Z9eRxr1Af7r26mS7HjFBgx9qyvOQVVMGszFa
         bOrnfTfqCNh5xLoZ+WkfinJ9aqgUOPjvjM+5hPLtgbKysn+5/66cOWcSQ4bEGUqw7eFN
         AYDQJTvmr4GGOlHcqhZqPituvIZjoPB8JLFpYNS8rpElWLd1IW27b/+ISR7dCDe15g0w
         bUog==
X-Forwarded-Encrypted: i=1; AJvYcCVwEMp+tsz18Kz6wh67GfM8ic2CukvPNI2+dI7sVgLO0SZmbrXO6hBzAU1IYPIt18cmuKxlKiip7Dbp32pWQZgiCyB+BnqMaBWEJ32bLE+UVvubO0DrYKaIZ2NYvQGgOphixRWoOJWD
X-Gm-Message-State: AOJu0YxmaXFtoUcbl4ZiIKcLRy2DjpWEbgRn2e0mmyUalZ7pgn58KO/d
	QU+0K4ZZymyIvZ4/bjsLFUwFcPecMzn9xOM5Fq14QYasjSKPBncG
X-Google-Smtp-Source: AGHT+IEzrVS22yW1RU7QOUnKEblxz1JzEyWdpvtohcd1nmbvvbyisaXhYPbg8tqys272nz+V2M+eXA==
X-Received: by 2002:a05:6a20:bb22:b0:1a3:701c:cca9 with SMTP id fc34-20020a056a20bb2200b001a3701ccca9mr4419642pzb.27.1711351995432;
        Mon, 25 Mar 2024 00:33:15 -0700 (PDT)
Received: from [192.168.0.21] ([119.82.122.244])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b001e0b3a87dbbsm2337472plh.177.2024.03.25.00.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 00:33:15 -0700 (PDT)
Message-ID: <287eb3f74e4c31adb065668ff49c8e1577388227.camel@gmail.com>
Subject: Re: [PATCH v2] Fix duplicate C declaration warnings
From: Amogh <amogh.linux.kernel.dev@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, 
	javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 25 Mar 2024 13:03:10 +0530
In-Reply-To: <Zf8--QSkEMDe9zyp@casper.infradead.org>
References: <20240323163148.23497-1-amogh.linux.kernel.dev@gmail.com>
	 <Zf8--QSkEMDe9zyp@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-23 at 20:43 +0000, Matthew Wilcox wrote:
> On Sat, Mar 23, 2024 at 10:01:47PM +0530, Amogh Cheluvaraj wrote:
> > Fix duplicate C declaration warnings at
> > Documentation/gpu/drm-kms.rst that was found by
> > compiling htmldocs
>=20
> I'm sure this removes the warning, but it removes all kernel-doc
> which exists in drivers/gpu/drm/drm_fourcc.c.=C2=A0 Isn't there a more
> granular fix than this?
>=20

After further introspection of the file drivers/gpu/drm/drm_fourcc.c, I
found that the warning is caused by having the same name for both the
struct and the function as in "const struct drm_format_info
*drm_format_info(u32 format)". This is an issue found using the latest
version of Sphinx as reported by Akira Yokosawa in message id
564cbd05-8788-9223-1ecc-59e7fc41b46a@gmail.com. So by changing the
function name to something like "query_drm_format_info(u32 format)" is
a possible fix. Question is what should I rename this function to, that
aligns with the coding standards? Also suggest a new function name for
"drm_modeset_lock" that causes the second warning.

