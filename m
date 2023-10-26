Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7F07D7BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjJZFBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZFBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:01:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC4193;
        Wed, 25 Oct 2023 22:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6xQyLzjRUd68pV8W/MBPmvs8ZsQ3s0uEEMwA3Kysizs=; b=WH7H+t7tFlGIDxMvTJ3/uleA8P
        HHte3sWDM2riHkIFI0FIC5QyoTwQj2vKYLx6n/42PQV9i4xoc7Z2GKsmLbrpbm7s6ZPw4gxEO7h4P
        qvaAkTm4VOSq608vSaiG2eFBgkcVoSfADYAQsmGqVALhJNS3DfCMDbDiGuMqWZZbcgLLkDOjuyEqQ
        dHniSgYa8JaZI65loqce1iZIxncY0tF4w6hqT3DQMTTf/H4YMBVa5P5QQAmBDokOBKI/nWfcCfioV
        jwkvLwyx4RF7jLcu2DqP31G/A3MVK7NIc0+EBRQ+wapqseWvVPtb/NGVF1a0lqid6P/+1ZcFX+LZj
        Qbfxkj3g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qvsUw-00DfLp-2c;
        Thu, 26 Oct 2023 05:01:34 +0000
Message-ID: <e4904bdf-2f7e-4727-9e27-5e131ae79798@infradead.org>
Date:   Wed, 25 Oct 2023 22:01:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: target: Fixed multiple typos in multiple files
Content-Language: en-US
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>,
        martin.petersen@oracle.com, bostroesser@gmail.com,
        michael.christie@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231023105915.29482-1-m.muzzammilashraf@gmail.com>
 <CAJHePoaNc6tJodB+vRM67Ac9NcAQ5x9gTC+g9P7-N3jWm5AfNA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJHePoaNc6tJodB+vRM67Ac9NcAQ5x9gTC+g9P7-N3jWm5AfNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 10/25/23 21:56, Muhammad Muzammil wrote:
> Hi,
> 
> Can anyone approve this patch?

I can review it. Please see below.

> 
> On Mon, Oct 23, 2023 at 3:59 PM Muhammad Muzammil
> <m.muzzammilashraf@gmail.com> wrote:
>>
>> iscsi: iscsi_target.c: Fixed typo
>> iscsi: iscsi_target_login.c: Fixed typo
>> iscsi: iscsi_target_nego.c: Fixed typo
>> iscsi: iscsi_target_parameters.h: Fixed typo
>> iscsi: iscsi_target_tpg.c: Fixed typo
>> target_core_sbc.c: Fixed typo
>> target_core_transport.c: Fixed typo
>> target_core_user.c: Fixed typo
>> target_core_xcopy.h: Fixed typo
>> tcm_fc: tfc_conf.c: Fixed typo
>> tcm_fc: tfc_sess.c: Fixed typo
>>
>> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
>> ---
>>  drivers/target/iscsi/iscsi_target.c            | 2 +-
>>  drivers/target/iscsi/iscsi_target_login.c      | 2 +-
>>  drivers/target/iscsi/iscsi_target_nego.c       | 4 ++--
>>  drivers/target/iscsi/iscsi_target_parameters.h | 2 +-
>>  drivers/target/iscsi/iscsi_target_tpg.c        | 2 +-
>>  drivers/target/target_core_sbc.c               | 2 +-
>>  drivers/target/target_core_transport.c         | 4 ++--
>>  drivers/target/target_core_user.c              | 4 ++--
>>  drivers/target/target_core_xcopy.h             | 2 +-
>>  drivers/target/tcm_fc/tfc_conf.c               | 2 +-
>>  drivers/target/tcm_fc/tfc_sess.c               | 4 ++--
>>  11 files changed, 15 insertions(+), 15 deletions(-)
>>

>> diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
>> index c81def3c96df..665eb2d9bc19 100644
>> --- a/drivers/target/target_core_transport.c
>> +++ b/drivers/target/target_core_transport.c
>> @@ -3447,7 +3447,7 @@ static const struct sense_detail sense_detail_table[] = {
>>                  * REGISTER AND MOVE service actionis attempted,
>>                  * but there are insufficient device server resources to complete the
>>                  * operation, then the command shall be terminated with CHECK CONDITION
>> -                * status, with the sense key set to ILLEGAL REQUEST,and the additonal
>> +                * status, with the sense key set to ILLEGAL REQUEST,and the additional

That could use a space after "REQUEST,".

>>                  * sense code set to INSUFFICIENT REGISTRATION RESOURCES.
>>                  */
>>                 .key = ILLEGAL_REQUEST,

>> diff --git a/drivers/target/tcm_fc/tfc_conf.c b/drivers/target/tcm_fc/tfc_conf.c
>> index 5ee03d1cba2b..4b066e14f885 100644
>> --- a/drivers/target/tcm_fc/tfc_conf.c
>> +++ b/drivers/target/tcm_fc/tfc_conf.c
>> @@ -281,7 +281,7 @@ static void ft_del_tpg(struct se_portal_group *se_tpg)
>>
>>         destroy_workqueue(tpg->workqueue);
>>
>> -       /* Wait for sessions to be freed thru RCU, for BUG_ON below */
>> +       /* Wait for sessions to be freed through RCU, for BUG_ON below */

Correct but doesn't matter much. "thru" is very common.

>>         synchronize_rcu();
>>
>>         mutex_lock(&ft_lport_lock);
>> diff --git a/drivers/target/tcm_fc/tfc_sess.c b/drivers/target/tcm_fc/tfc_sess.c
>> index 593540da9346..e2ff506ca68d 100644
>> --- a/drivers/target/tcm_fc/tfc_sess.c
>> +++ b/drivers/target/tcm_fc/tfc_sess.c
>> @@ -98,7 +98,7 @@ static void ft_tport_delete(struct ft_tport *tport)
>>
>>  /*
>>   * Add local port.
>> - * Called thru fc_lport_iterate().
>> + * Called through fc_lport_iterate().

ditto.

>>   */
>>  void ft_lport_add(struct fc_lport *lport, void *arg)
>>  {
>> @@ -110,7 +110,7 @@ void ft_lport_add(struct fc_lport *lport, void *arg)
>>
>>  /*
>>   * Delete local port.
>> - * Called thru fc_lport_iterate().
>> + * Called through fc_lport_iterate().

ditto.

>>   */
>>  void ft_lport_del(struct fc_lport *lport, void *arg)
>>  {
>> --
>> 2.27.0

All of the other changes look good to me.  Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

I.e., it can be merged as is -- up to the maintainer(s).

-- 
~Randy
