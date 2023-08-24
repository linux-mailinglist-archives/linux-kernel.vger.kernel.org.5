Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE217875C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbjHXQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbjHXQnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:43:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABAE1FC7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:42:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf7423ef3eso788005ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692895377; x=1693500177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKAEvxLjTVn245O1vlngwoyLqQ4EnTwo2ZEykgaML2g=;
        b=DTP5sck+hGp4VP5P4OlaLrCHznJq05pkiacow+ru2IdytwcD6TCx+G+BwEVflu89iA
         KILLkjFtMxqtX6vyS2aLmMb8pum0K4IsPYJaMMu67nY4hS+SCRDZhYeQWc9QQTP1F/Jq
         9gh9Ol/ahssEpbcTfWIMPkNLxG37AgXwhnkCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692895377; x=1693500177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKAEvxLjTVn245O1vlngwoyLqQ4EnTwo2ZEykgaML2g=;
        b=h4iVhC4fNwTn1PsbXqAPb6SQfZD3yafyuduY3PKwhG8LTISSKCxyDrFl0aULfBymyq
         TEoy5DvSH9pMoUWMvmmFiDU67EGSaA02y3hwcbrt8xS/cB3mLgA3MJTniIxWtmtLJYvf
         0zP+noMIUFR+hw3B+8bGOncPBkV5ZuXsXPULnTZ64U5bL5+ylUUKivHcO2ig9pWWo7p4
         MTbRB2Ogtf3aaTDMW+YA4Ex3Gv8rnkm6HNgb3Q/ETVIn82iKjdCMNjHGf2IdNI+BDakY
         Okv4jqKjnuuNdPRClCEvasWye7eZkOS8AN5XymPag281NoZeK1XS1QvkxSA5vDZFR8EB
         YCRA==
X-Gm-Message-State: AOJu0YwBiY5i2qnC0Pun/9KWq73n8qlck1WAX2CNSUyh4PvT6oDy/Zm3
        O63gulzM6AwHcYmJ9SV3Ehg0TQ==
X-Google-Smtp-Source: AGHT+IGltQ5W+Uo9QcdF+cHDC1x/LHmjvCbvq4IbIxBFvEkViKPvnsLfajUquv6YGdXxKJJvuG3JwQ==
X-Received: by 2002:a17:903:4283:b0:1bf:4859:53df with SMTP id ju3-20020a170903428300b001bf485953dfmr12655931plb.0.1692895377295;
        Thu, 24 Aug 2023 09:42:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001bdb8c0b578sm12966988plh.192.2023.08.24.09.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 09:42:56 -0700 (PDT)
Date:   Thu, 24 Aug 2023 09:42:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     luto@amacapital.net, wad@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Remove =?utf-8?Q?unne?=
 =?utf-8?B?Y2Vzc2FyeSDigJhOVUxM4oCZ?= values from prepared
Message-ID: <202308240941.E3CC7885E@keescook>
References: <20230825184348.6870-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825184348.6870-1-zeming@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 02:43:48AM +0800, Li zeming wrote:
> prepared is assigned first, so it does not need to initialize the 
> assignment.

I prefer to explicitly initialize variables so that later changes in
the code cannot suddenly leave a variable in a surprise state. :) The
compiler will do a good job removing redundant and dead stores.

-Kees

-- 
Kees Cook
