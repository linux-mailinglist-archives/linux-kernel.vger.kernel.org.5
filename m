Return-Path: <linux-kernel+bounces-105806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3B87E4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205A42828B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0750D25761;
	Mon, 18 Mar 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/QuOR6w"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1924A19
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749459; cv=none; b=OymZPtV+wbbXlQ+7iOav2NJ9mCq6cqwKyVhWgQn1MojZQkzpmda7Tkb24pYbQoSVGAtrUz4OJUOdCqlwqIyPD7ghNw9dKyNfCKb11JdzARH5vUGNVdUt5yLi13H8XCn5HQEG6mRqaJrlM6Y/X6pkCpQ+tlh8fJxXNwU46KbH88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749459; c=relaxed/simple;
	bh=opmeh9JyNTU62HaqhKhjZQzYJINRflOWclmPToSuOvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkhNOEjIgLx9wMNpN4jEw+dA2cSRP5zet6Qs9mTRG94MYQZRcgEHJ1InRC2WK6MRmxIl6mGMy/w2OUCdRqqGvGLoYohCFswPQg/IpzgzmEw+YpAgc3Kw8AfwSdhLpZ22z9Kyuks6x23SdA7S80Vc3UsIiZW+YiCtXsxhNmhSqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/QuOR6w; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46ba938de0so104205066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710749456; x=1711354256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E4DNi1tThxPrAjwj3MNLTkspc0oafwDCMGAENKTid3c=;
        b=j/QuOR6w9TSdjgU1TlaZerDTlRnKi4MwLIK6OD5Z6wf5Bi6Lc23Uy2w4CBDNoheNoi
         xNliQLXJJTvrCjWG3Mz9BEKmHl9awVjwFYCU7pRVoj/uwifDQ9252CK35c9D8BDyuClr
         XiM1/j/Dcx/tfo8bR62SWXBq4/tJyOVN6cAwJC1Evut9WeJaDFY7a0SfQ8pP8oAbC1Zk
         Y5xlS7pDOFqnFej6ulWXp7ncnwgzFHdGEFV7vB4jbTVD+aHD6E0cUX3iNOeLMiVW9Hy+
         hlmZmLlOQnbfsZGqcrctcKfl7ejBP67mUFItk39yw5XTnNIMxK53mIg1/YLWTbdorixk
         qqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710749456; x=1711354256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4DNi1tThxPrAjwj3MNLTkspc0oafwDCMGAENKTid3c=;
        b=FYc54URn5e2BQzFNOf/qtf6QdAYfzVii2qMUH6poKVpuYTxiojnYGn04eEXHPyHz/1
         wEcQvW1LtIMgh8RWI/hgEoyJWW90rdbaj6VMF3PD7vuFqvo8Yp3zaiCsAulHbn6DVmyb
         dz2a2RaM+Yu0tUnA7L6p9+C9oPIoCE5hCG5fXfpYWb1rSqujkaBr6kp6DUxmcPpAcS+r
         t5XXx2/1bAaJ/ovnz1/DuBmlX/FbVbM726rvuPpq0q+oKoElSs/hzCf+YXxdRDuYzuDb
         DIqgMHXgjAdQULzodhWJhhpZK7IOCudJhK8fcgwK5Nh9y67Bt1mn9m6NF5OYFEidRbhm
         BFDA==
X-Forwarded-Encrypted: i=1; AJvYcCVccu1vO7UggQGL3GDv7ciRbp5/ROrhOa6JgNH+OZrAcB/8MJJYCDCMpcADxTVdlDSlxfxyJta02eijK3TcTXBrSAmwXEndaMGozaqM
X-Gm-Message-State: AOJu0YxeKqOvWmi4giTwJWjBRRDtjKCfBQFWqrTnrd85BET1HbMqdK6g
	+uy0LDd9yexsaLRvH5HJ9Gum5uT2B130mpGJ85wKC6Wj9n90z/WEWmcPmTXE+Gc=
X-Google-Smtp-Source: AGHT+IF7QDTquWD+I+K+G6iw+g4y541SJ1nIcz4EIs4ACVb80u6p6Zv/G7HRDxnFSFtqQ8VONOtvKQ==
X-Received: by 2002:a17:906:ca17:b0:a46:cef3:4aba with SMTP id jt23-20020a170906ca1700b00a46cef34abamr125127ejb.75.1710749455840;
        Mon, 18 Mar 2024 01:10:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id dv22-20020a170906b81600b00a4658d3e405sm4531600ejb.196.2024.03.18.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 01:10:55 -0700 (PDT)
Date: Mon, 18 Mar 2024 11:10:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <a315177e-a9b1-4110-a176-8a909335c56f@moroto.mountain>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
 <Zff0IO6nqpMiGXl5@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zff0IO6nqpMiGXl5@nanopsycho>

On Mon, Mar 18, 2024 at 08:58:24AM +0100, Jiri Pirko wrote:
> Sat, Mar 16, 2024 at 10:44:40AM CET, dan.carpenter@linaro.org wrote:
> >Automatically cleaned up pointers need to be initialized before exiting
> >their scope.  In this case, they need to be initialized to NULL before
> >any return statement.
> >
> >Fixes: 90f821d72e11 ("ice: avoid unnecessary devm_ usage")
> >Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >---
> > drivers/net/ethernet/intel/ice/ice_common.c  | 4 ++--
> > drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
> > 2 files changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> >index 4d8111aeb0ff..4b27d2bc2912 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_common.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_common.c
> >@@ -1002,8 +1002,8 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
> >  */
> > int ice_init_hw(struct ice_hw *hw)
> > {
> >-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
> >-	void *mac_buf __free(kfree);
> >+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
> >+	void *mac_buf __free(kfree) = NULL;
> > 	u16 mac_buf_len;
> > 	int status;
> > 
> 
> How about similar issues in:
> ice_set_fc()
> ice_cfg_phy_fec()
> ?

Yeah.  Sorry, I'll resend.  Smatch didn't warn about those bugs because
the sanity checks are the begining of the functions:

	if (!pi || !aq_failures)
		return -EINVAL;

are never true...  It's the first time I've run into this as an issue.

regards,
dan carpenter


