Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45C37D4DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjJXKX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjJXKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:08:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AEC10C8;
        Tue, 24 Oct 2023 03:08:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20DF42183F;
        Tue, 24 Oct 2023 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698142123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmPXYrB8Lp48Rfx2Myfdry2JFLsDxc2LzyiAmxkxNbQ=;
        b=0BczDCGxqQVKfSoJneW+eH9O2u9S5pL0DPO4PgwLOjEzLjxVq5nNObl+aDSlbn4QN2esip
        LAsbswu1zThfi2MeKCLICb4dQ8Zi2rz1ovsR8VM+X02JRMrYUpXhp+CRCNDVvA8l6QRZXG
        dh5imCcxalfZcqQJ0sxLnSfyRkbKfYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698142123;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmPXYrB8Lp48Rfx2Myfdry2JFLsDxc2LzyiAmxkxNbQ=;
        b=3xLRUvMOZi5y+wJaJEd58/vtwfxqLwfCnnX+0YtQx8CI/H0JeT4dSEtYBBSQcfPhUvVZm/
        nA9vKs0tz5JXUWAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EE89134F5;
        Tue, 24 Oct 2023 10:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OMdNA6uXN2X9GwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 24 Oct 2023 10:08:43 +0000
Message-ID: <057db5dc-d940-4662-8b51-a20fd7037402@suse.de>
Date:   Tue, 24 Oct 2023 12:08:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] scsi: libsas: Delete sas_ssp_task.task_prio
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-8-john.g.garry@oracle.com>
 <346bdffb-8a59-445e-a352-f3f1912fda1e@suse.de>
 <e102ba93-8fb9-1754-1881-0cd322c808d6@oracle.com>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <e102ba93-8fb9-1754-1881-0cd322c808d6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -10.23
X-Spamd-Result: default: False [-10.23 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-2.14)[95.84%];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 12:07, John Garry wrote:
> On 09/10/2023 07:55, Hannes Reinecke wrote:
>>> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
>>> index d77db53cbd8d..5b2e6932c564 100644
>>> --- a/include/scsi/libsas.h
>>> +++ b/include/scsi/libsas.h
>>> @@ -565,7 +565,6 @@ enum task_attribute {
>>>   struct sas_ssp_task {
>>>       u8     LUN[8];
>>>       enum   task_attribute task_attr;
>>> -    u8     task_prio;
>>>       struct scsi_cmnd *cmd;
>>>   };
>> Hmm. While true in general, we lose information on how the 'prio' 
>> field is coded for the various drivers.
>> Would it be an idea to use explicitly state TASK_ATTR_SIMPLE
>> in the various drivers such that we know what to fix if we ever
>> decide to bring task attributes back to life?
> 
> The HW encoding for these drivers is the same as in the SAS COMMAND 
> frame - Command information unit structure, right? So the amount of info 
> lost is reduced. And we also have source control history.
> 
> I'd be more inclined to get rid of setting task attributes similarly as 
> well.
> 
Fair enough.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

