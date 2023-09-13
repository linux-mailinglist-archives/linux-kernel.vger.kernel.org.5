Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9144379E35A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjIMJR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjIMJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:17:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4E31999
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:17:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso72352715e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694596670; x=1695201470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAjwj3vFJAui/OGA0IHuJXUUcCG/qk5wDLNVjB5au/s=;
        b=18+d0PIpCYfc4xrPlb6/2mgS+3+jK2Ue8dFX6/LDI5x17PaCpmMvi9N2UJ0s+g7kAC
         XuhCMqKbzFqelftL9VT8dSYNxaH8Ec/nL02krxzI1Y2g8vw3oVvOhUOf4Bn/25ttbNka
         CUgn6eQP71Ib9NiYSE6Bfhj87SP0PuTBfZgPrKOXf1h3GhWSdJBj42CSCFmTFAcvN94F
         naQKNFECoQbWglKsjDBveMr2cDmL2rV6AQcwwKKf6SvgHchr7Io85wAtD3YhkJSGVXLu
         n/g7TfX4SsRv9TWUjV2EfvHdVpRTEOtV1STIA4c8d2oPA+dMGIal6fJQVSSglqZZSVnn
         c5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694596670; x=1695201470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAjwj3vFJAui/OGA0IHuJXUUcCG/qk5wDLNVjB5au/s=;
        b=afz+S9yBgWL9+teh3INy480KVmnlBhjT4jSPKWKDoWHylNlrEyhB+ilox5k5JhfjXT
         IHIGx12/eqiXcB+k7NlqusnRFq74v+ygyhjRXbda60uAQ5Id/8v2QL88H8EIE2RQgOen
         dTx2auMK+IVgV7/v8EJx0Ibap41O/0SLVHDIK+M//hGmduI5OMj3tOlFXUblY51IrLHx
         +h0xxDyibi5fzE7WK7vGeLD7jZEdaMD0zIGVCPV+6VkfOeDNPPSR3gonHlk81yYLD3dJ
         d2ZJD+mSj7nQsspYEQC2VW/bBAk4kX8QwexoOwrPv6nOvujlaUXcDWXngQDZVcg2xcsd
         QTnQ==
X-Gm-Message-State: AOJu0YxYb6qLZxOAdmSg8pfehS5r5l+k8rTcDDQAVUJeEevtq1MLrR7E
        JeWPAVMT6Z7xNosiuwQqBI4PuQ==
X-Google-Smtp-Source: AGHT+IGYrZIoH7RVHwDTt7jAikBWmHKVtRJY8VFrQZWdVrpcxA9ztB//ZndOBHoEMjiTRYDolro5tw==
X-Received: by 2002:a05:600c:2212:b0:401:b2c7:349b with SMTP id z18-20020a05600c221200b00401b2c7349bmr1553594wml.7.1694596670178;
        Wed, 13 Sep 2023 02:17:50 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bca4d000000b003fe4548188bsm1450437wml.48.2023.09.13.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:17:49 -0700 (PDT)
Date:   Wed, 13 Sep 2023 11:17:48 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jinjian Song <songjinjian@hotmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, loic.poulain@linaro.org,
        ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, nmarupaka@google.com,
        vsankar@lenovo.com, danielwinkler@google.com
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Message-ID: <ZQF+PHTYDZRX1gql@nanopsycho>
References: <ME3P282MB270323F98B97A1A98A50F8F7BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME3P282MB270323F98B97A1A98A50F8F7BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:
>Adds support for t7xx wwan device firmware flashing & coredump collection
>using devlink.

I don't believe that use of devlink is correct here. It seems like a
misfit. IIUC, what you need is to communicate with the modem. Basically
a communication channel to modem. The other wwan drivers implement these
channels in _ctrl.c files, using multiple protocols. Why can't you do
something similar and let devlink out of this please?

Until you put in arguments why you really need devlink and why is it a
good fit, I'm against this. Please don't send any other versions of this
patchset that use devlink.

NACK.
