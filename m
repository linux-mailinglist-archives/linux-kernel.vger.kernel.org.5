Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043B7774231
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjHHRga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjHHRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A343B97D64;
        Tue,  8 Aug 2023 09:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A5E26257B;
        Tue,  8 Aug 2023 13:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367C6C433C7;
        Tue,  8 Aug 2023 13:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691502173;
        bh=zBkCs0ied0oJOF5B9ATFfVmexO2qqYBG0XVuyV9Fb/k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tdA0AI12m0PoUPJPdC1bvjoS4eBusetvceucQvjDSXpX91FeXi0Gosf4+2GwmH60H
         3mNVyHeagJwKqOkRV3DQ8kgoPKgaG84SWDR/6JCh6X/Q3GTL4H+ifuETuFB88jeMW5
         sqHotqKCjMSmW23LdsobzgWHpkeCuTjssZiBjYi9z3s7zXBjT2+2MMljC/dHmaql6V
         6nU0lBKY9HmSuKgJIE/+0O2w5SpwmN3mZE39sp3S5M7KwccE6839JkshjAjvIcOkkr
         WJt1dgynh+IF6EzumcJOAFx6DrxN5LGQb47gY3FNVXM7d2EEgeLvqMmkZv0a3NHHV7
         iW3u73cInE6GA==
Message-ID: <d3c1c2cb-9076-523b-da81-a1b632b4b0f5@kernel.org>
Date:   Tue, 8 Aug 2023 21:42:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
References: <20230310123604.1820231-1-chao@kernel.org>
 <b53321ab-679d-e007-6407-6bd00149948e@kernel.org>
 <yq17ct0nijm.fsf@ca-mkp.ca.oracle.com>
 <f93949dd-e90f-a9bf-33b3-4f31c4328c7d@kernel.org>
 <yq1sfabni01.fsf@ca-mkp.ca.oracle.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <yq1sfabni01.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,

On 2023/6/29 10:02, Martin K. Petersen wrote:
> 
> Chao,
> 
>> Any progress on this patch?
> 
> I'll resubmit this series for 6.6.
> 
