Return-Path: <linux-kernel+bounces-13933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82072821505
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC02281A26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E42ED536;
	Mon,  1 Jan 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbi/1msl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672EED51C;
	Mon,  1 Jan 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da202aa138so2436318b3a.2;
        Mon, 01 Jan 2024 10:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704134577; x=1704739377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXpEDsxUBs30PjcuzXJKBSUE53akb2fmSYFoDxvovTM=;
        b=nbi/1mslcGzmMIz32nN7C+QGGqRF7fDQOvn6qNtjdBuXLWCzuOkDO9m1VqkhpId4dS
         TwiZGBcUY/WjirHHXCgAYq1LTqKXXSoPxLXIP1e4rFyeu8TbIelSYAs+7222Zb+DbzNE
         snX1VR7CJPSuJQVbyLge/vOr3cN8nzwVgLClnF+/9trsKDBLnu5wMq7XqmpT7b7coxJZ
         CMr8irBd9WnqqOi9n1GWZ9VbNxVLGXAD3pUpppOSO6KlZiYO7rgZiwGJK+CGfq3cHykO
         i8DjpvuYDQWzM4anKJpo2bTIke68vSKww1nqclmxAkDyUnR/lGblZC3Z5ap0FBmBnPBS
         b9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704134577; x=1704739377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXpEDsxUBs30PjcuzXJKBSUE53akb2fmSYFoDxvovTM=;
        b=DUmWfUVZEJULh6zu5uwFfHxtST+Fx9dp5u8LO3tXpeO7Cwr883FSIjwV5Kopr756V2
         ohEe6Q2AWX6JYz9g45aXXxB7j3afMmdnjaK77Hi4r8XAEtDSuYVVV7IEWwyGwlukk/S5
         92RucobreJC6geOzMkjK8s5DOek6KLfXRZ2kfEZdWG8U+bbX28vbmoJwTdW7MhC5myi0
         WM/aIDyOyH3GpV/+duM4c1P3heSNkxeGHldB7BxNndrfq3/OPAkmdvFQrP2DH0rviFNO
         b0ugBI/rzXokYRRBsaBfL0ztuR+r6cvJWdZ+2T4aDntyINVsIy642CuSrhLDujORORVU
         JuuQ==
X-Gm-Message-State: AOJu0Yz30DsytvSHhujNXjmWsQXOOxMVpUxCy2hn4GcuvAAGIwHQdtUh
	zDAPteHTjImM/HuTuY3D/Wo=
X-Google-Smtp-Source: AGHT+IEGKbbya1JiPVkF6HuEjruBerUaZtRPaCQhpdlyAsla3IOxlDxmoDNQLnF+DHjzPNm+ZGEixw==
X-Received: by 2002:a05:6a00:a24:b0:6da:4d93:ef74 with SMTP id p36-20020a056a000a2400b006da4d93ef74mr6770774pfh.6.1704134576593;
        Mon, 01 Jan 2024 10:42:56 -0800 (PST)
Received: from localhost ([2601:647:5b81:12a0:8134:8b90:8d31:15e7])
        by smtp.gmail.com with ESMTPSA id c12-20020a62e80c000000b006d5929810a6sm14617801pfi.83.2024.01.01.10.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 10:42:55 -0800 (PST)
Date: Mon, 1 Jan 2024 10:42:54 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Lin Ma <linma@zju.edu.cn>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/sched: cls_api: complement
 tcf_tfilter_dump_policy
Message-ID: <ZZMHrqMO3sc6iINd@pop-os.localdomain>
References: <20231228064358.3042747-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228064358.3042747-1-linma@zju.edu.cn>

On Thu, Dec 28, 2023 at 02:43:58PM +0800, Lin Ma wrote:
> In function `tc_dump_tfilter`, the attributes array is parsed via
> tcf_tfilter_dump_policy which only describes TCA_DUMP_FLAGS. However,
> the NLA TCA_CHAIN is also accessed with `nla_get_u32`.
> 
> The access to TCA_CHAIN is introduced in commit 5bc1701881e3 ("net:
> sched: introduce multichain support for filters") and no nla_policy is
> provided for parsing at that point. Later on, tcf_tfilter_dump_policy is
> introduced in commit f8ab1807a9c9 ("net: sched: introduce terse dump
> flag") while still ignoring the fact that TCA_CHAIN needs a check. This
> patch does that by complementing the policy to allow the access
> discussed here can be safe as other cases just choose rtm_tca_policy as
> the parsing policy.
> 

This patch looks good but you could use NLA_POLICY_MAX() to validate
TCA_CHAIN while you are on it.

Thanks.

