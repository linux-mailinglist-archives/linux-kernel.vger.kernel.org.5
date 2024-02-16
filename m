Return-Path: <linux-kernel+bounces-68597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB9C857CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517DA1F2382D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACCF1292E0;
	Fri, 16 Feb 2024 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NAeRzwHM"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471212883D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087931; cv=none; b=ZtomVC+cVpYsZLjhMikLrEP3mTQ/DoLdWAV8kZG58OQZUZjBgksvCEGozDvWIcIrcD8b18ZMthxKdJ/XGEuP5kRMdxnyUl7BUiM5bsJmtCfF/53RAiwkDxsNKCtTk/lFp9GcTPBHf91rEgznXnlBv9thhXvJZgz6V7e2U4a5d5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087931; c=relaxed/simple;
	bh=pE/r6+xB3dzintHnnqc2M0R285DNLssjnyBlOWPpovg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8LsCGTXCzfI+Temy5eNQNo/66G1mezyXpj+x56YyjrT2z+ZgIzzEnnM0KP2ciJLaY44m3gF3cfuPov+q3Zpgm0IAQR6Vx8b41YrY5UT2IWhfLvCkLle9HCJsFfqgOW+CWnjadXBkF1zrGpnVv2EzTQjx/wSmKZgRYnoSUccLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NAeRzwHM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso473860a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 04:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708087925; x=1708692725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pE/r6+xB3dzintHnnqc2M0R285DNLssjnyBlOWPpovg=;
        b=NAeRzwHMVuMwPDLmVTt3la0rkO+dWY1Bm0ndQSPnsY4Z6fCkUFiACxb3zLvr5xL3cR
         eZmp6nH83tF+nacmEtHYSNAO2FJQEpA1DeEWtpwB+ytQ6c3Mzo2q+iRJcSSqwm1ohG48
         YAnk+TfDkiFeP4pyRC5kd3H86XEMaS8RXRQJZSVJ8du5Cg/YoHXwIW7GZYJ3pOKa8JvI
         rZlCcMSnCloXlrqP2mviAcSUcgJ/+5D5PAdg1FsTrsmaB3sTsW3eo9NPMWNrYJwGQqIL
         3iOHIqwxx6sR+Nn5wJSCx0Jhk01JJSANXtFS6QftD2VBGsDjCcgrRLy0Yz9Et8zQVDtm
         Hx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708087925; x=1708692725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pE/r6+xB3dzintHnnqc2M0R285DNLssjnyBlOWPpovg=;
        b=m2Mtra4MinsD9PWl0dlzXus2SoeSKtvnTrRJgz18ZEZ2vnFNEN64KztDHpy5TAFqEV
         NapmQcqTc9PrtZ6t4+daSadjS/LijoQlX6F2SlJrF4To6IudDpkiZ3DkymJUmwAfuWfT
         td5LzO67GdOKREuZYc4u1jYOXiSa7jGIiKsY0saph+ug0/ou7Ols3UXpNfegkbTnPZW3
         8vwsB6aq2T9YFbrRUulFhoOh6VuioOgHg/2WD9+CZFowiAOgZ4ShcZrlpSfBZh5JwjCA
         iFXaaxsmj2lTnEw2YI1aBAdyotNe4zZcIFbIadVA05dMk40b9Jzsm3SpKP3f66JDoOHt
         r4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXy9ssgN0ZShgJVlKrJXj8DcwB2vfQr6NKKlrdBUTw/jvt2zj50OHKV/rq3qw7M3Vxu84zzkHWesM3HglwYgD9j5MCCYepqOENLd9Dl
X-Gm-Message-State: AOJu0YxQwqU9wqke05/gtYVxg719dljj1tyHuWWS7c/nV+Nsi3jDc3AN
	GOg5sOBoQp65SLQoIMGqU/2jLat2QcZKujhmt8pdnfaHygXdmITI0qhjkebDEqI=
X-Google-Smtp-Source: AGHT+IFRBKb/J9TVj5LcjAPyURuoUyqdHkJtfwCi4Sl/QZ1XMIhc2qmgUFA+H+LpAaevvSb7nPXWTg==
X-Received: by 2002:a05:6402:1045:b0:561:cec7:cb1b with SMTP id e5-20020a056402104500b00561cec7cb1bmr3344924edu.32.1708087924910;
        Fri, 16 Feb 2024 04:52:04 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id eh15-20020a0564020f8f00b00563e97360f9sm558625edb.31.2024.02.16.04.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 04:52:04 -0800 (PST)
Date: Fri, 16 Feb 2024 13:52:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llu@fiberby.dk
Subject: Re: [PATCH net-next 1/3] net: sched: cls_api: add skip_sw counter
Message-ID: <Zc9acSjD6Cf6UFrz@nanopsycho>
References: <20240215160458.1727237-1-ast@fiberby.net>
 <20240215160458.1727237-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215160458.1727237-2-ast@fiberby.net>

Thu, Feb 15, 2024 at 05:04:42PM CET, ast@fiberby.net wrote:
>Maintain a count of skip_sw filters.
>
>This counter is protected by the cb_lock, and is updated
>at the same time as offloadcnt.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

