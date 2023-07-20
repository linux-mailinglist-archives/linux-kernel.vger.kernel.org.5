Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6746775B7BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGTTOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGTTOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:14:44 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D34270C;
        Thu, 20 Jul 2023 12:14:33 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: B103C20176.A84CF
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:136:242:ac11:f])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id B103C20176;
        Thu, 20 Jul 2023 21:14:31 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689880471;
        bh=XjIQhXMj6DqsEk4Hf1da40N0NTw/NbVJuF//Vsu0skQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dkI6E2LjLRqUBzRMfgJdZZ2/8yhveyYDf7TDKUt/HZ41oRnWHoIBQ+3EbcjihiZ+Q
         ZsOqdEBDzSVpEwugIDWHPlYtu64587V+H8o2U5iEN+og0WsxlMlGuxLmWmJT1mpfSo
         9+EGXOTP+AFgpZj+KtqvwPvdjO1Cup2woUgBtBiA=
Received: from [IPV6:2a02:1210:6c17:f000:af2b:c1b5:c15b:acda] (unknown [IPv6:2a02:1210:6c17:f000:af2b:c1b5:c15b:acda])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 6AD51D4E6A33B;
        Thu, 20 Jul 2023 21:14:31 +0200 (CEST)
Message-ID: <6d261882-9e51-d64b-083a-439e615e4eca@cs.kuleuven.be>
Date:   Thu, 20 Jul 2023 21:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] selftests/sgx: Harden test enclave ABI
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <20230719142500.13623-2-jo.vanbulck@cs.kuleuven.be>
 <CU76CMOCVA8N.PM4O08WT1DZA@suppilovahvero>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <CU76CMOCVA8N.PM4O08WT1DZA@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.23 19:27, Jarkko Sakkinen wrote:
> 
> Since the amount of tests is increasing over time, I'd put here:
> 
> /*
>   * Explanation what the test does and why it exists.
>   */
>> +TEST_F(enclave, poison_args)

Thank you for the code review! Will add.

Best,
Jo
