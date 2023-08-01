Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CEF76A77E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjHADbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHADbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:31:39 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984C91BC7;
        Mon, 31 Jul 2023 20:31:37 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0DB4090108E;
        Tue,  1 Aug 2023 03:23:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 89F8F90106F;
        Tue,  1 Aug 2023 03:23:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690860217; a=rsa-sha256;
        cv=none;
        b=a8SG6Ws+6T/1GiXldgiPJiYpOZ26rOGSGQKfi+y/FeVIrMRufgYmi/wQivHRIgtZ4J32U3
        zXSAthzOHyJyRvzvRdTpst4bS1tGslP5ZB/6IAfKFqqEbCeb1yf0kM0Mtv6NPoNFeFvNkY
        MU6KXDRciLjOf4fgjXh/P7YyHgVrWj41QgNg1GSXseROgwzpquMHNlvZT6/SMgXaGMPTcq
        ujl6IR0bmTO4dshbufuQXqkMYcNKg4pF5Nw2Bg79HeewyE/gM3RASgtnGysYOwKo4+vfFw
        kF6EcbBdAxKhxqmIVtHEb43+bZ+f/sHKg1hzjB4Mwpv1aWP2MeePaAxa1ZlAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690860217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=EVokbC9sqCzqTBizE65suosBfXjzjvxy76/UCH5cCpU=;
        b=ZI8rjckEvdyf83TK6ipG86D0jkGPoX8WDtOINo25/WplF0LvuHT5qcgHY1Fuz458okPsER
        nYpIFwVztqx8HahXa8o0JezTM4zXXxO1OWGpwcD70MUs1AzLTTDaLMNVzr+pbigwnOxyBg
        OM7dSe6mHGTJYGgSMl7EEWLVOmOYk0eGGmms/15JYW6E9ictsjTqm0NR2vjvi8V4rFs10Y
        hofItlrXKoCgtT064MdtNlU2KT1SV20WGEMGei/Uq5VQCEUQY404dbV4kfIt2B9rQfB3ax
        tI4FJiUUVVzn/Hxz+kJNqF2/CLqtAngXh5tL/d1OhFhwVEUXJD8mjn04h3cagg==
ARC-Authentication-Results: i=1;
        rspamd-849d547c58-xc6tw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Share-Thoughtful: 024708fa33c9dbb4_1690860217854_3725728623
X-MC-Loop-Signature: 1690860217854:2378317259
X-MC-Ingress-Time: 1690860217854
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.60.171 (trex/6.9.1);
        Tue, 01 Aug 2023 03:23:37 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4RFL6b6lC3z4G;
        Mon, 31 Jul 2023 20:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690860217;
        bh=EVokbC9sqCzqTBizE65suosBfXjzjvxy76/UCH5cCpU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=fgcQJP/Vc1QIcO/XmLU2Em4anvDyO2nPYTBwb7HshcwiIXDstrrMeNhsF1+aYvCom
         SXsyVs2Y+vyqa/hvFDyyAmcjzNougbRy39Md6/dmKs4xBT5EbMetGElW/vujBRKVHL
         ZMl/r/rAF6aA2qkmBJkyfQPEmFMWwYGZXBeWZM1sOUavjrRCcsVrayseDXJj/bH4xl
         b6fyEAAJ3ErmO0+NwhqPrqDO6AQtPSTkNr3C+feNAYBaQcNJ26fv6VataKaQSDyxr7
         Q5Rs4mj2qy7gkIqpJyHJCTjj/dKFbc3LLw14fbBuF8Whv15w/GOx+r1QsUcdLLx7/9
         okgHFQBt13oUw==
Date:   Mon, 31 Jul 2023 19:46:01 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/memdev: Avoid mailbox functionality on device memory
 CXL devices
Message-ID: <ogv7evtgf5rcljd4ev7rxx6buqg7y3kwlqing2tfshh2ac5zf6@juclnksnv4ki>
References: <20230728-cxl-fix-devmemdev-v1-1-dbd3269b3295@intel.com>
 <64c4562fb7531_a88b29481@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <64c4562fb7531_a88b29481@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023, Dan Williams wrote:

>Ira Weiny wrote:
>> Using the proposed type-2 cxl-test device[1] the following
>> splat was observed:
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000278
>>   [...]
>>   RIP: 0010:devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>
>It would be useful to decode this to a line number, the rest of this
>call trace is not adding much.
>
>>   [...]
>>   Call Trace:
>>    <TASK>
>>    ? __die+0x1f/0x70
>>    ? page_fault_oops+0x149/0x420
>>    ? fixup_exception+0x22/0x310
>>    ? kernelmode_fixup_or_oops+0x84/0x110
>>    ? exc_page_fault+0x6d/0x150
>>    ? asm_exc_page_fault+0x22/0x30
>>    ? devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>>    cxl_mock_mem_probe+0x632/0x870 [cxl_mock_mem]
>>    platform_probe+0x40/0x90
>>    really_probe+0x19e/0x3e0
>>    ? __pfx___driver_attach+0x10/0x10
>>    __driver_probe_device+0x78/0x160
>>    driver_probe_device+0x1f/0x90
>>    __driver_attach+0xce/0x1c0
>>    bus_for_each_dev+0x63/0xa0
>>    bus_add_driver+0x112/0x210
>>    driver_register+0x55/0x100
>>    ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
>>    [...]
>>
>> Commit f6b8ab32e3ec made the mailbox functionality optional.  However,
>> some mailbox functionality was merged after that patch.  Therefore some
>> mailbox functionality can be accessed on a device which did not set up
>> the mailbox.
>
>cxl_memdev_security_init() definitely needs to move out of
>devm_cxl_add_memdev() and after that I do not think @mds NULL checks
>need to be sprinkled everywhere. In other words something is wrong at a
>higher level if we get into some of these helper functions without the
>memory device state.

Right, so we can move it directly into cxl_pci_probe() - just as with other
mbox based functionality. This leaves me wondering, however, what to do about
the cxl_memdev_security_shutdown() counterpart. As with the below diff, leaving
it as is and just adding a mds nil check might still be considering a layering
violation in that it would be asymmetrical wrt to the init; but this is tightly
coupled with cxl_memdev_unregister().

Ira does the below fix the crash?

Thanks,
Davidlohr

----8<-------
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 14b547c07f54..4d1bf80c0e54 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -561,7 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
  
-	if (mds->security.poll)
+	if (mds && mds->security.poll)
  		cancel_delayed_work_sync(&mds->security.poll_dwork);
  }
  
@@ -1009,11 +1009,11 @@ static void put_sanitize(void *data)
  	sysfs_put(mds->security.sanitize_node);
  }
  
-static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
+int cxl_memdev_security_state_init(struct cxl_memdev_state *mds)
  {
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct device *dev = &cxlmd->dev;
+
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct device *dev = &cxlds->cxlmd->dev;
  	struct kernfs_node *sec;
  
  	sec = sysfs_get_dirent(dev->kobj.sd, "security");
@@ -1029,7 +1029,8 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
  	}
  
  	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
- }
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_security_state_init, CXL);
  
  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
  {
@@ -1059,10 +1060,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
  	if (rc)
  		goto err;
  
-	rc = cxl_memdev_security_init(cxlmd);
-	if (rc)
-		goto err;
-
  	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
  	if (rc)
  		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f86afef90c91..441270770519 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -884,6 +884,7 @@ static inline void cxl_mem_active_dec(void)
  #endif
  
  int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd);
+int cxl_memdev_security_state_init(struct cxl_memdev_state *mds);
  
  struct cxl_hdm {
  	struct cxl_component_regs regs;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1cb1494c28fe..5242dbf0044d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -887,6 +887,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  	if (IS_ERR(cxlmd))
  		return PTR_ERR(cxlmd);
  
+	rc = cxl_memdev_security_state_init(mds);
+	if (rc)
+		return rc;
+
  	rc = cxl_memdev_setup_fw_upload(mds);
  	if (rc)
  		return rc;
