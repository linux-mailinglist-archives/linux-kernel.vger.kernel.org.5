Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0778E7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbjHaIMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjHaIMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:12:47 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D238B10C1;
        Thu, 31 Aug 2023 01:12:19 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: A095F201C5.A0869
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:132:242:ac11:16])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id A095F201C5;
        Thu, 31 Aug 2023 10:12:15 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1693469535;
        bh=Fc1QIZGJW7EBrznNL6p2o2N2WSglP4bI3szUzAb6e4w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cy2Bqk49teXsRI1Sb0h0kwhrkF6DRv0hE2UMULeivKqX/h0R5Exo3YIQqP6eoxCCZ
         rgYMw7Gqt15nFajhIXqvzeGknNUOM6DupWQeNhaY+2IgaZ5FBBZPbZWLgHXttatNwL
         lcZtyXJqDCSciF/9kXo5d97rCMZhKYXIaBG6yrZA=
Received: from [IPV6:2a02:1811:d31:8b00:7de6:eac8:3ad6:e6b8] (ptr-82s0fs7jt2487ph2gu0.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:7de6:eac8:3ad6:e6b8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 63462D4EBEFF8;
        Thu, 31 Aug 2023 10:12:15 +0200 (CEST)
Message-ID: <03045151-dec9-e271-9f88-f4d2d57476ab@cs.kuleuven.be>
Date:   Thu, 31 Aug 2023 10:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/13] selftests/sgx: Fix uninitialized pointer
 dereferences
To:     Jarkko Sakkinen <jarkko@kernel.org>, kai.huang@intel.com,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
 <20230825133252.9056-11-jo.vanbulck@cs.kuleuven.be>
 <CV3JM96HKCU0.2ZSE4CAS0QV9A@suppilovahvero>
Content-Language: en-US
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <CV3JM96HKCU0.2ZSE4CAS0QV9A@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.08.23 20:36, Jarkko Sakkinen wrote:> Bug fixes should be always in 
the head of the patch set.

Thanks for pointing this out. I'll make sure to move this to the head in 
the next patch set revision.

Best,
Jo
