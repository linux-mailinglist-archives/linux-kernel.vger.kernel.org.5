Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED97747B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjHHTR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbjHHTRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B679BFAEF5;
        Tue,  8 Aug 2023 09:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2FCE62592;
        Tue,  8 Aug 2023 14:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03657C433C8;
        Tue,  8 Aug 2023 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691503935;
        bh=Gdw0yHvTeezw/jw3SrhRILCCcZGJNShWGWctFVDSQXw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p9Ex+c9JWhnxp4g5gnrSMuTgVk63I4xv5r2TH8SDBw522pwboI/4X68yNbw7ZJdrw
         soIDcT+lK+Z+EyiSDU+TyLm/7P7smOGOakAV5mgzp/IzN79had7SyduuDuhU/WRWV1
         PvgEJcdBXCupXQWalygjRncAXxbNkd/RdsV9lkP+N5H9fMww50oBbx4JJ+dQDAclLl
         niDLS1hPp2vqKhPYFrqPJgIA2SCQiZAZLN5YuwNt1+IDsBGxg9VAVB+mzQYKfEAQLy
         2qam6hbntG3k4Oaz5NP6ksT2AZRZ/nwF27UMiv94/JHU4Ff5eI/7PmRaciixfwdZ0b
         HkKl7Ht5QZLPA==
Message-ID: <067b15a6-1db2-719b-918d-286be4966f11@kernel.org>
Date:   Tue, 8 Aug 2023 22:12:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230310123604.1820231-1-chao@kernel.org>
 <b53321ab-679d-e007-6407-6bd00149948e@kernel.org>
 <yq17ct0nijm.fsf@ca-mkp.ca.oracle.com>
 <f93949dd-e90f-a9bf-33b3-4f31c4328c7d@kernel.org>
 <yq1sfabni01.fsf@ca-mkp.ca.oracle.com>
 <d3c1c2cb-9076-523b-da81-a1b632b4b0f5@kernel.org>
 <yq1h6p9k4vk.fsf@ca-mkp.ca.oracle.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <yq1h6p9k4vk.fsf@ca-mkp.ca.oracle.com>
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

On 2023/8/8 22:04, Martin K. Petersen wrote:
> Been working on this series to address the reported regressions. Spent
> quite a bit of time on it last week.

Martin, thanks for the help. :)

Could you please share the report? Maybe I can join to check it.

Thanks,
