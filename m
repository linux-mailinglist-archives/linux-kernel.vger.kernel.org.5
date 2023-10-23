Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2917D2C86
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjJWIVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWIVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:21:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CD2C4;
        Mon, 23 Oct 2023 01:21:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09788C433C8;
        Mon, 23 Oct 2023 08:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698049309;
        bh=XrV2myKEdPltpSB/WUfNxpDSBHC2mWbdDw5pNtMkL6M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HsfhGDoEfPjA5VsgPB61n9vuRtS3rRWTBrMJxZ+Bo6tM7z/z1gY0ODdqkX/ootUpJ
         Uij7KHHIZAD7GmoTmzl6XhMuIRY8TEbBY0l8mDHPeSARhZkKnGMPpK+gCULQ//D3r+
         ESETdzNLGF7IZoadYoeNWuUZwKxheYvcUpkxjmhDUXc2/pujLP6qtSQgzSPRqwItF0
         Um9MD+/JpCiu65SLBEBdnxCTTdYrkaCk9+0nuJ4hcR/At4IBjLx8ayusk2RgFn43S+
         2BV94J8y3n2MvzJZ2bSeuIG74HYw+b4AVo27cCwAb58ghmEPDd5pITeNozVmQnolaq
         fMxm2jlP0If8g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     pkshih@realtek.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write
 RF mode table fail
References: <8734yff8vr.fsf@kernel.org>
        <20231022090901.430143-1-amadeus@jmu.edu.cn>
Date:   Mon, 23 Oct 2023 11:21:45 +0300
In-Reply-To: <20231022090901.430143-1-amadeus@jmu.edu.cn> (Chukun Pan's
        message of "Sun, 22 Oct 2023 17:09:01 +0800")
Message-ID: <878r7t21gm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chukun Pan <amadeus@jmu.edu.cn> writes:

>> _Why_ is that warning printed? Are your devices uncalibrated or are they
>> somehow else special?
>
> I don't know, but not only my rtl8822be wifi module will have this call trace
> every time when the driver probes. This can be considered a common problem.
> So I prefer to disable this call trace and use the driver warning instead.

Why do you say this is a common problem? AFAIK you are the only one
reporting this issue, right? It would help to understand _why_ you are
seeing this, ie. what's the root cause? Just randomly removing warnings
without understanding the root cause is frowned upon.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
