Return-Path: <linux-kernel+bounces-98183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D3877624
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C3BB20F9A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 10:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C331EB5B;
	Sun, 10 Mar 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYWsdHYM"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4459C1EB23;
	Sun, 10 Mar 2024 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710067541; cv=none; b=ZMxGrr9KMuaZq1RyBHFsMgIfu9KTpTeUjBLCYpA2gqEI0fvAzZccEkxeMQuiQZ93/An9SasaSr8lqsMmMxI4p7RXvt1lrKQOyPDmm78R1zTq+xkpLVb9mC0Y9DpbvSJsbtwgr3/lSjYEZdjIu8sKkaE5hOBpWvecIbJueyZnrZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710067541; c=relaxed/simple;
	bh=TxP61Svxv1Z1G0KcqQCe329Ydbu2E2d9Wa6rwAuMW7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+p1JWysWTgUTexmPmSfPvGvC3WwUGd7yvqCTKCpCLjcY17wYZzQFGXBLSv8rHl60m5vTsiO3gJ1whQT/WL0cN8GFfvO2k/SeecsX4QDwwj68o5tyaf5rxtxN+j5b1FDDHR1PJ+2STSeajGBV6dIXjMvnZAH2UIKczynuCWY8Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYWsdHYM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e95b68b3dso81136f8f.0;
        Sun, 10 Mar 2024 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710067538; x=1710672338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TxP61Svxv1Z1G0KcqQCe329Ydbu2E2d9Wa6rwAuMW7A=;
        b=dYWsdHYMOSQDdcqQd2Ydt/3XaCzpiLF6XqfU2mmLotRxpZ91f+wBX4tLPsar/R8GAj
         mv80PG3fhB151e78RBNNHsX2JORClZ0ji02XefXOZk7IQq7IMKhIQVoJUhynI3qOkwkk
         8o3tc0qMvkqaXa5tSEMnIWLS5DvPI6iH0oP/j1gqFdvB/c4i1yx848ZB6XwryUjK4B1W
         N32q/ObPewHt/uQjDNe6w8+hjlRLUCEuOfvz3SUR5y7ge5E10ZDDmliUpqJXei1T+VFj
         Hap511hpSfkXLBAgcJLr1wJRtu+Q7I7cMakQ4bCUBsMj/6QOTwf2CsJIa+GX+2TqiCEC
         INFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710067538; x=1710672338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxP61Svxv1Z1G0KcqQCe329Ydbu2E2d9Wa6rwAuMW7A=;
        b=WAfzrc2+9d3i1A/WZQMgvc0O2FBnpA3gTcN3j8CRdv9IKeXhpLrvhOfei7EeaUB54u
         Ocg852V8Vf4p7Fw4bYH2FaPlpdSAB6hDBtV8JxqCeKuRcSeZxCCpGmVnfBgwyINLV7Y+
         PMsJ6wE6M/RZDsPEeSe7HA2nlvuUtuk3EL0Goc2CeTPBBoF9r2xGQaImqTOgw0hywzVH
         bKZzNxgZPYCT5roGi95icUtQX5QUtRIZtcbggRFetL/kSrGlYJKqm/G5g3NA8f2zRR3X
         WQ2eXXUJazpRB+KUCD+NKxermGp6tpChGB5DuvUD9TQD4cgwHanW/RxXpLsNIL7CflGM
         z65A==
X-Forwarded-Encrypted: i=1; AJvYcCVFWqANV2k8k766jwkeDrsgiCo/vFln16ig76CqztJxupzxGalFYFQSPjGHzYGolwEjFMU4MV40tAayH/agWrYfoA+1H2hntGqsDTgZtZFtCw9vm3A2DcdivSgOPLAHZVU8FChc/E2U
X-Gm-Message-State: AOJu0Ywz5FqZXx/hdkEyidRRZ8o094iN1A8S0mJtA25m1PRfsDLVgHN9
	YLAM+JvG96b6/CJnhX1bElVB3Dpp9QLZM1vPIccz2x1mbzvS9UMRlFAQBsE7/Zc=
X-Google-Smtp-Source: AGHT+IE7ENyLlO7LAGnBj7Gvr795dqnUqmwEFNXEJfq6m6CvF/yXl0PROLuXj6fVJsWpd2x7m18hPQ==
X-Received: by 2002:adf:edc9:0:b0:33e:7133:ee31 with SMTP id v9-20020adfedc9000000b0033e7133ee31mr2425703wro.40.1710067538431;
        Sun, 10 Mar 2024 03:45:38 -0700 (PDT)
Received: from debian.local (80-44-66-160.dynamic.dsl.as9105.com. [80.44.66.160])
        by smtp.gmail.com with ESMTPSA id q4-20020adf9dc4000000b0033b6e26f0f9sm1988784wre.42.2024.03.10.03.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 03:45:38 -0700 (PDT)
Date: Sun, 10 Mar 2024 10:45:35 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: regressions@lists.linux.dev, trivial@kernel.org,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix typo in reporting-regressions.rst
Message-ID: <Ze2PT8oamTSm23ny@debian.local>
References: <ZeoDMtLGIHvbavW2@debian.local>
 <cd766a41-4dfa-4f57-8af2-163023acbead@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd766a41-4dfa-4f57-8af2-163023acbead@leemhuis.info>

On Sun, Mar 10, 2024 at 08:57:55AM +0100, Thorsten Leemhuis wrote:
> Which leads to the question: how much do you care that you patch makes
> it in? If you would like to have a fresh commit in the kernel (which is
> totally valid thing to want!) we definitely could improve your
> submission and then adjust Nícolas changes on top of it -- but if you
> don't care at all we could just directly take Nícolas patch.

I don't care - just take the other patch. But please fix the multiple
incorrect spellings of colon ('collon') first.

