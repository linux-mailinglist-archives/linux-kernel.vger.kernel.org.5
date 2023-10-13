Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14747C814B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjJMJCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMJCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:02:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13095
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:02:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so19778875e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697187753; x=1697792553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EitIIr0VXZPrROTEdWmf6yr6Gf534q1TtiPqr2MAdms=;
        b=P5gw1lSxFWqDyqqsOzqXu9gaomefAWdo5mUlMrLj2pQ2jmG6A+HQKfB4Id0IJ12VO5
         LIiVRngEJrISpWdpPeabqviPQU+LBO53+Ku8uPAza0aNmarC51L6mxOFHs1lfkU092tJ
         3K4eHNVCk5tiWi+o9jneQq4CZ9gPXxwipr7xY91SkRuDrabklVO/qkh9BFsi06XHIYqR
         cGz3FebA+KjdSgHHmNA2a6O6/Ig0/ajL9tNY2OOF9++TpNcDUVXD/ZrVs4b/qzg3GZ2g
         yh5qZUS7kv1aB37ZgWyrzKVJhoKYTvAttQjek9JP8evkyTIvm/uT8zXB1cKU0V7mw7dw
         trgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697187753; x=1697792553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EitIIr0VXZPrROTEdWmf6yr6Gf534q1TtiPqr2MAdms=;
        b=eZmsE/HdB7/chVO8BeydCgYOgFkgzi4s+8+kZ2Grda90LdLGh78AgwUOrUP4yIp5nm
         ZK/KJkrHKIJcf3l/cneGEF3ZtReadKLs3XjqKcLRbHP5JDooFx94BqSCcP1DJMQ3iFYz
         K2jcblX0lBPnn/1KUJJipbdKCpIWGR8Z4qxCczQojIlWb0eJavH4V/5BNAboJ7Vt2oXm
         7T+UXeBv2kSSGQ6vEeBMyAPkcdT6N1iQtJ98tnl5hyGhTsirOMnwhLQukmTWW/iLw1et
         Jwbv1zN0Zb2svynvqbEdb/OZp9azfKwd6TeKo6ucPPwnvOklHM1asod5yb1/s2232Onk
         EEMA==
X-Gm-Message-State: AOJu0Yz+D4tdNPswc479zjJLv1J/KZwSpmX6h1No5Rd8xdNdSa5HsxIn
        MA+9kBejbnfiVJOgj0IM81dIFg==
X-Google-Smtp-Source: AGHT+IFxQE0qP/giysqEOTM31qj+xVscrqwLDA5oxLN8m7e4fQRA0KQWqxJw1XjX9TXSjwe3miKOlA==
X-Received: by 2002:a7b:c394:0:b0:406:51a0:17fd with SMTP id s20-20020a7bc394000000b0040651a017fdmr21825469wmj.18.1697187752956;
        Fri, 13 Oct 2023 02:02:32 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p16-20020a1c7410000000b0040586360a36sm1943484wmc.17.2023.10.13.02.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 02:02:32 -0700 (PDT)
Date:   Fri, 13 Oct 2023 12:02:30 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: wlan-ng: remove unused functions
Message-ID: <62778e4d-cc2e-4310-b334-52b54cfe7e79@kadam.mountain>
References: <ZSjpQlUcyOoYv4Yh@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSjpQlUcyOoYv4Yh@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 09:52:50AM +0300, Calvince Otieno wrote:
> The following functions were defined in the prism2mgmt.h file but neither
> declared nor used anywhere. It is recommended that they be removed.
> 
> 	- void prism2mgmt_get_grpaddr(u32 did, struct p80211pstrd *pstr,
> 				      struct hfa384x *priv);
> 	- int prism2mgmt_set_grpaddr(u32 did,
> 		                   u8 *prism2buf, struct p80211pstrd *pstr,
> 	                           struct hfa384x *priv);
> 	- int prism2mgmt_get_grpaddr_index(u32 did);
> 

Could you look up when the functions were deleted and add that
information to the commit message?

    These functions were removed five years ago in commit 123412341234
    ("delete functions").

regards,
dan carpenter
