Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16463771A02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjHGGHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjHGGHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:07:05 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B81724;
        Sun,  6 Aug 2023 23:07:02 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 360FD2016C.A7649
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 360FD2016C;
        Mon,  7 Aug 2023 08:06:59 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691388419;
        bh=vo2vKLGfT7lup78gRTtsKKXog9tMvYYCJG1cHKh0xBs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PcWhzB7a96kkwjX+aDL5sZovrbQUrBmIXJqQBG941BMefspcUaLrXeH4z9VzDERmR
         mjSEXtjUj9ZemxDuNW9yzj2UfEEN7SIY6vonz/XeBtHs53ReYE7SjwWLjP2Us8BCWP
         qnaSscn8Yt76m1KRkesojTJkcCGGPsdxzvaHFzOY=
Received: from [10.101.1.242] (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 8F953D4F780D6;
        Mon,  7 Aug 2023 08:06:58 +0200 (CEST)
Message-ID: <d1b884b4-830a-88f5-7818-0e7d0ca2ef1b@cs.kuleuven.be>
Date:   Mon, 7 Aug 2023 08:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] selftests/sgx: Fix uninitialized pointer dereference
 in error path.
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
 <20230724165832.15797-2-jo.vanbulck@cs.kuleuven.be>
 <CUE1EZWZ2B1V.3RB2KB8Q2A52W@seitikki>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <CUE1EZWZ2B1V.3RB2KB8Q2A52W@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.23 21:03, Jarkko Sakkinen wrote:
> Add a fixes tag. In other words, find the commit ID that caused the issue
> and add the output of the following to this patch before your sob:
> 
> git --no-pager log --format='Fixes: %h ("%s")' --abbrev=12 -1 <commit ID>;
> 
> BR, Jarkko

Thank you, added for the next patch revision.
