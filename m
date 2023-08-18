Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D299781837
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbjHSIEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344717AbjHSIEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:04:14 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F29170E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:04:11 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: C8CC720169.ACD2B
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id C8CC720169;
        Sat, 19 Aug 2023 10:04:09 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692432249;
        bh=pMbe2H+w2QbKj/eLua+N8JNNwe1FArNtRBJQafs9JYU=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To;
        b=YtLsg5m3rQNcBfvPiqsSZTxK9B7A7fG1k2Jf4UM0Ey6O9UgVXCo6wvOfWdb/8+GC1
         6smM2pasp1ZrPjOcE4IP9Tt1/u5HLEQJ7/HkS2wGJMn536+Yw4MggZ8j3WktmHcGAX
         OwZ4/YNaus97WNX6nU62J7WsML0e0l3ZWhXtjDoc=
Received: from [192.168.44.147] (ptr-94-109-233-233.dyn.orange.be [94.109.233.233])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id ECD24D4E69702;
        Sat, 19 Aug 2023 10:04:05 +0200 (CEST)
Message-ID: <2ca80bc7-1b9f-27f3-3149-e84af995927f@cs.kuleuven.be>
Date:   Fri, 18 Aug 2023 15:34:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: Re: [PATCH v2 0/1] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
To:     Sohil Mehta <sohil.mehta@intel.com>, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        mingo@redhat.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com
References: <20230812155448.8865-1-jo.vanbulck@cs.kuleuven.be>
 <906599be-2fb2-a9fc-7d1c-77e9dd6f986d@intel.com>
Content-Language: en-US
In-Reply-To: <906599be-2fb2-a9fc-7d1c-77e9dd6f986d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.23 13:43, Sohil Mehta wrote:
> You missed updating the version number in the cover letter subject.
> Also, it is useful to have the version number in the individual patch
> subject as well. (Just something to keep in mind for future patches.)
> 
> Usually git takes care of it automatically, if you do this:
> 
> 	git format-patch --cover-letter -v3 -1 -o patches/

Thank you for catching this and pointing out the git option, this is 
indeed very helpful to keep in mind!

Best,
Jo
