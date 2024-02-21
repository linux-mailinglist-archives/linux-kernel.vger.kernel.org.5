Return-Path: <linux-kernel+bounces-75221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE0C85E4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8C828568C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915584052;
	Wed, 21 Feb 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwFzm2dW"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CC82D9B;
	Wed, 21 Feb 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537481; cv=none; b=UviiAjkADM4yWZq9YaA3fQ6LcTMgQReTWDvZ+i0B3IQsMG0K9w67S1xGcSc/5LIl9/7dL8o4C8VwnVshVL4SA+50iQ1n3eIjmNBQbo/kdcNuWB9Lw+NMezHT3oXirhn0qT6a3qcKvRC7bMgXDJkneK1J3KDE+FtOpmEQXXULDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537481; c=relaxed/simple;
	bh=0bVEmtCEZemUuHzFPFzyEjeI011XV9VpYcqB7Ty1Qg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8iwD3PHRsqyfFOMv424p/FEFL14pUq2L5ldfsJyj0jDTtYyDG/ACBzcT6jRuzlyBKigtzYhG/iFjELR14haY/paEAyJ7fO3cEvx+Moi3jbXVZplpKQy4+nI+ymxuB++pOG1lviBZ2TNFM3EKmjwow24OuIaadXQe5yXYqg3Owk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwFzm2dW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d911c2103aso40265805ad.0;
        Wed, 21 Feb 2024 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708537479; x=1709142279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7L75x0M1Aq5vNN4NtGjAz1me5yaRbWCvbVsbiNBVrA=;
        b=HwFzm2dWVNVo63BulK/xBf7rVZr/sVCqhagxPFCOOOqupfmvNOOQ0BNe03qydYIVCU
         0tqhRc4CIN+alFn/hy8Tgw3SPn4G0mEtfb7y4ezNw2kj038+ZG2669y5OC6t0312MTWV
         RSiBcXs5HH9okmNDXje8zbJrAME2VTOUgBxDfFiQEi9BJWxPsDlQQrCofgGNzSYsQ/Oc
         zP9w3ULSeg4lGUW/db4Gau4XpgYL8Nmi8RUBmb1D5Or/EEkNzral7DLiSmWyEkiS7b1f
         JqJm+mV23+3Bx5iPD0zPAuT1o8DF3zr84QbCZlJVk4ozM0ZJgRSeXHx9SUH5ej6kt+Mq
         ldcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537479; x=1709142279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7L75x0M1Aq5vNN4NtGjAz1me5yaRbWCvbVsbiNBVrA=;
        b=UexuNCc+CLFGU1GFlQON3QJvx5H8sYXlrca1UaHH3CgCYFAG/nBl8XxRehbxryVMQC
         0hygOEnPEOxNV5y92ekQlH+90ja2xfJea585Xv+TX7QzL8gsyGb/Qss7TcQwxcWfgFVU
         fxDIFGTLSb9knRvjO6M13SdRrnOKQ2EV49QHP0vezAwG4wctr7tosGFbRbbn2VkmotfD
         XiG5+zn9zpgZpa+fyKmFVhGziU17bBOo2xiXdj4EQH6OdismGEw9v8KfTyI+iO9Vfl2I
         d9PsOKtz+fm6000XrXbfpFadCKxvXad+7syEZIIEMCv4XJR2hYYJ7zPudnQc/Vn//pnk
         q1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeFLumLQFyBuM4Ol03R4KpeZ0FTGZPrl4+9KIQDPcSKWeZWAl5LDuPbNjJsupLUPu8fhGARW5vjKHWbN8f1vAXdALtsOTjdGPyFdDRj9Sutw1M6TPGc44R//mogKfRrLohDVX/K7mb
X-Gm-Message-State: AOJu0YwS/17dlT+PHKGRPqw2BbGDzmAHJakglHWsx0/AfPX6NpxZ8CRF
	uSh3tXa0LsguYZgq9yDoJM3WLyN+/H7z9eNzBpA3jvGDJ+U5aBFK
X-Google-Smtp-Source: AGHT+IEeUA5r8/iLK8UqzJD4T6RJRFX0/T0ITD61nkOelDszmQoLLUPvwK0OUQY8BtPucwyTSXN55w==
X-Received: by 2002:a17:902:ccce:b0:1dc:30bb:b5cf with SMTP id z14-20020a170902ccce00b001dc30bbb5cfmr2903189ple.59.1708537479511;
        Wed, 21 Feb 2024 09:44:39 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001dbcf7f43c9sm7704885plg.303.2024.02.21.09.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:44:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 21 Feb 2024 07:44:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, jiangshanlai@gmail.com,
	corbet@lwn.net, paulmck@kernel.org, rdunlap@infradead.org,
	peterz@infradead.org, yanjiewtw@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ke.wang@unisoc.com
Subject: Re: [PATCH] workqueue: Control the frequency of intensive warning
 through cmdline
Message-ID: <ZdY2htJ5D0FisH1M@slm.duckdns.org>
References: <20240219074634.2039-1-xuewen.yan@unisoc.com>
 <ZdTXWrB8dascOIM_@slm.duckdns.org>
 <CAB8ipk9R3hRSTTEEBn8nvOcTZGBtaDQfomXiQwji+DTKgLghwQ@mail.gmail.com>
 <ZdWNvolkfPCyMNj9@slm.duckdns.org>
 <CAB8ipk9FtgYh5Ho-nFQCwUO8zOPEk73VS0KHFDuRS9yxDRpe4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk9FtgYh5Ho-nFQCwUO8zOPEk73VS0KHFDuRS9yxDRpe4A@mail.gmail.com>

Hello,

On Wed, Feb 21, 2024 at 07:00:55PM +0800, Xuewen Yan wrote:
> This way looks simpler, but it could not disable the warnings, but I

Yeah, I meant that it'd make sense if the value 0 disables the warning.

Thanks.

-- 
tejun

