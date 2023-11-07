Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7692C7E35BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjKGHVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKGHVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:21:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFC0C6;
        Mon,  6 Nov 2023 23:20:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B3AF20709;
        Tue,  7 Nov 2023 07:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699341657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1kH32KdMcwEqd9YWjZ6gV9dvz/fjH5OMah+VhfN184=;
        b=cNI35Fm+9DgfnIym2tEgAETrVrA0cIft3WFj0ocV3g/W4lCGt4xUCtad8WLzrmHpyq/qGE
        HhMlCgIk6mWSu0jjdzoZ8oDxMD0fA72DJL7Unpg0gxMT7KoNJYfwU4vh2xoAnZxOmIY6bz
        oquOANuvDpvtEMfsVeVxwt6EkK7uG1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699341657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1kH32KdMcwEqd9YWjZ6gV9dvz/fjH5OMah+VhfN184=;
        b=nPB4/7/a2ZGPu/nn5uYXPg4KRiTb+kOE7+RGKbvFJIyNjVrMYspTdLTQkQ6ONRrRZ0Mge4
        t/cJDWAeSTozpKDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C130F132FD;
        Tue,  7 Nov 2023 07:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gqnEK1jlSWU2MAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 07 Nov 2023 07:20:56 +0000
Message-ID: <32be196b-4742-4411-adc5-bb0220470662@suse.de>
Date:   Tue, 7 Nov 2023 08:20:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] scsi: fnic: Add and improve log messages
Content-Language: en-US
To:     "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
Cc:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-4-kartilak@cisco.com>
 <41c2fd4c-f6b3-450f-87b3-d059d52ba2f0@suse.de>
 <SJ0PR11MB58960545FE72C28A91D3585AC3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <SJ0PR11MB58960545FE72C28A91D3585AC3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 20:55, Karan Tilak Kumar (kartilak) wrote:
> On Thursday, November 2, 2023 12:28 AM, Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 10/27/23 20:02, Karan Tilak Kumar wrote:
>>> Add link related log messages in fnic_fcs.c, Improve log message in
>>> fnic_fcs.c, Add log message in vnic_dev.c.
>>>
>>> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
>>> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
>>> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
>>> ---
>>>    drivers/scsi/fnic/fnic_fcs.c | 36 ++++++++++++++++++++++++------------
>>>    drivers/scsi/fnic/vnic_dev.c |  4 ++++
>>>    2 files changed, 28 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/scsi/fnic/fnic_fcs.c
>>> b/drivers/scsi/fnic/fnic_fcs.c index 55632c67a8f2..203ffec625a4 100644
>>> --- a/drivers/scsi/fnic/fnic_fcs.c
>>> +++ b/drivers/scsi/fnic/fnic_fcs.c
>>> @@ -64,8 +64,8 @@ void fnic_handle_link(struct work_struct *work)
>>>                      new_port_speed);
>>>      if (old_port_speed != new_port_speed)
>>>              FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host,
>>> -                           "Current vnic speed set to :  %llu\n",
>>> -                           new_port_speed);
>>> +                           "fnic<%d>: %s: %d: Current vnic speed set to: %llu\n",
>>> +                           fnic->fnic_num, __func__, __LINE__, new_port_speed);
>>>
>> Please update FNIC_MAIN_DBG() to use the 'fnic' structure as an argument, then you don't have to prefix all messages with 'fnic<%d>'.
>>
>> Cheers,
>>
>> Hannes
> 
> Thanks for the review comments, Hannes. I'll make suitable changes in v3.
> Please advise whether I'll need to supersede v2 with a "git send-email --in-reply-to" so that your
> "Reviewed-by" tag for other patches gets preserved.
> I'm not exactly sure how the process works. The goal is to reduce the number of re-reviews of patches, if possible.
> Any pointers with respect to this will help.
> 
Please add the 'Reviewed-by' tags for the next submission; that will 
indicated to reviewers which of these patches already have been reviewed
and which need further attention.
Hint: there is the 'b4' tool, which will scrape the patches from the 
mailing list _and_ add the 'Reviewed-by' tags. Maybe give it a go.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

