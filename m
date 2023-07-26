Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4947763224
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjGZJbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjGZJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:30:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225A211B;
        Wed, 26 Jul 2023 02:29:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso3837496b3a.2;
        Wed, 26 Jul 2023 02:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690363756; x=1690968556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrB7Qi5dqHrz8cDTbgt7pGFf6VPuvPmMU9xcqmpYYwQ=;
        b=gScQjFOjmX/EC3YJZSdTSS72sehY+SMQ0EMkbv60Se1hfaW4HdCkvPGkG+V2a3wtpv
         1nQPamgCETSbzp5StTi6ScHSS9dJ4GvFONPvf+V8E2HFpOf9Ag1kq7/XfOum83fDK1q6
         50GogIEUYnsvkYPTLq5tsDX057xpXv6lUB6shaqzueiDZf58xRDp93qSOJAt2WKg76Ow
         k4hFx2qaakwvJNII2+JtBHLptw6dS90B942ENNsIzYDJlfGjzFcgI6a9x2ESt3VV7nBD
         rDLu5HS7xJZpRfDWaYBaAYPPBq62+bvve5+KiJEnjHbcaertCZHBzmGcAv23LdSYyZDp
         5KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690363756; x=1690968556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrB7Qi5dqHrz8cDTbgt7pGFf6VPuvPmMU9xcqmpYYwQ=;
        b=RNAiKdVXdwmHByu29JmnsiyePe2UrQG0S1WR5LvTo938FkYQ7NN+3fUYySwdBPhr0W
         iJtUNk15hQvk1nbX3rzywl39MAD09joj4YAeUJ+WKy6bckH9q81QUXddHQNLO6twSZUY
         R+0QV3J77sLwIEr9TEL0DTb+rbaGbAD/wFoUtC26R4tHYjcsCltOM5RdTKxfrBZWfqc0
         iWXGtgSBMgrUb3alDJEzFhMsFG3BaCav5+gK/81yNY8xmv005KrNn9wqsfvGdxl22fEh
         6eGtOwHbOl0Yd/5q7ncLGzxJ4CrnresvvO+5a3uf2kO9XonmhyL6K+Vj0ajDEVlOtfXm
         SZvA==
X-Gm-Message-State: ABy/qLZNkmlRlExfWZJWvljV6yP2RsryxL3j4xX0A+Sxh58cSgay8nbN
        mFSJ4J6GDR3RWcJUpmS23xU=
X-Google-Smtp-Source: APBJJlF9TAHrJ+Ll+dUDANN9n5QrysXKA0k0S4H83YIEnbiojwif21ES5d9hKPIWFazPXAyEPh31SA==
X-Received: by 2002:a05:6a00:3a1d:b0:662:f0d0:a77d with SMTP id fj29-20020a056a003a1d00b00662f0d0a77dmr1339284pfb.30.1690363756293;
        Wed, 26 Jul 2023 02:29:16 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t26-20020aa7939a000000b00640f51801e6sm10966696pfe.159.2023.07.26.02.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 02:29:15 -0700 (PDT)
Date:   Wed, 26 Jul 2023 17:29:10 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, razor@blackwall.org, lucien.xin@gmail.com,
        jiri@resnulli.us, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
Message-ID: <ZMDnZhXaoKCui9ad@Laptop-X1>
References: <20230726075314.1059224-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726075314.1059224-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 03:53:14PM +0800, Lin Ma wrote:
> There are totally 9 ndo_bridge_setlink handlers in the current kernel,
> which are 1) bnxt_bridge_setlink, 2) be_ndo_bridge_setlink 3)
> i40e_ndo_bridge_setlink 4) ice_bridge_setlink 5)
> ixgbe_ndo_bridge_setlink 6) mlx5e_bridge_setlink 7)
> nfp_net_bridge_setlink 8) qeth_l2_bridge_setlink 9) br_setlink.
> 
> By investigating the code, we find that 1-7 parse and use nlattr
> IFLA_BRIDGE_MODE but 3 and 4 forget to do the nla_len check. This can
> lead to an out-of-attribute read and allow a malformed nlattr (e.g.,
> length 0) to be viewed as a 2 byte integer.
> 
> To avoid such issues, also for other ndo_bridge_setlink handlers in the
> future. This patch adds the nla_len check in rtnl_bridge_setlink and
> does an early error return if length mismatches. To make it works, the
> break is removed from the parsing for IFLA_BRIDGE_FLAGS to make sure
> this nla_for_each_nested iterates every attribute.
> 
> Fixes: b1edc14a3fbf ("ice: Implement ice_bridge_getlink and ice_bridge_setlink")
> Fixes: 51616018dd1b ("i40e: Add support for getlink, setlink ndo ops")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
