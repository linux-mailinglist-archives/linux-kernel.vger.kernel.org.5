Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6781F7FE8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbjK3Fi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjK3Fiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:38:55 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9436193
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 21:39:00 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231130053858epoutp03d661793524a284caf462e9d6debbddaf~cUARN2uDP1507115071epoutp03g
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:38:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231130053858epoutp03d661793524a284caf462e9d6debbddaf~cUARN2uDP1507115071epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701322738;
        bh=AwXYEEVHcvV3S/ajD9i4L0qerh5l4o65/EouB/56Wy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JXGDMjmM6HLaJDssXGG6PbDSf6QJsNTKokHdFo79bNRKfoxymanzUQrf04rc4HiWi
         +Iv9wDuk7Tgmg+WxAnhbzwckXd2TjvFwX6TPT68JfEM+rgGqeziAyw28OkM8Vb+8W9
         qfbJLb8jRi8zfBNDc5G3qOiCQNeab2p488+4yOcU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231130053858epcas5p4a3511e2de128a5435a08d08da6a140d1~cUAQ0hbeh3076230762epcas5p4u;
        Thu, 30 Nov 2023 05:38:58 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SglNw70F2z4x9Q5; Thu, 30 Nov
        2023 05:38:56 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.9C.09634.0FF18656; Thu, 30 Nov 2023 14:38:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231129105501epcas5p415ce4aaa65bd771d074cedaa77ef2c02~cEq75Vat11053110531epcas5p4y;
        Wed, 29 Nov 2023 10:55:01 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231129105501epsmtrp27a248fc8c69c60745aa90591add6566b~cEq73L9KV1131511315epsmtrp2E;
        Wed, 29 Nov 2023 10:55:01 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-6d-65681ff0d19a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.73.18939.58817656; Wed, 29 Nov 2023 19:55:01 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231129105459epsmtip216ec737777cda4beaed8df1cf5b31a84~cEq5so4rk2956529565epsmtip22;
        Wed, 29 Nov 2023 10:54:59 +0000 (GMT)
Date:   Wed, 29 Nov 2023 16:18:37 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
        gost.dev@samsung.com, nitheshshetty@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: Update type from size_t to u16 for
 opts->queue_size
Message-ID: <20231129104837.arls2gn3wttiqiff@green245>
MIME-Version: 1.0
In-Reply-To: <0cd6862e-8037-40b3-9fde-b7f10d66e31c@suswa.mountain>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmhu4H+YxUg5ZWM4vVd/vZLD7Ma2W3
        eLTMz+LmgZ1MFitXH2Wy2L3wI5PFpEPXGC2eXp3FZHF51xw2i/nLnrJb7HjSyGix7vV7Fgce
        j1n3z7J57Jx1l93j/L2NLB6Xz5Z6bFrVyeZx59oeNo/NS+o9dt9sYPPobX7H5tG3ZRWjx+dN
        cgHcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCn
        KymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyB
        ChOyM27eWsFW0CpbcekySwPjC7EuRk4OCQETiaYNu9m6GLk4hAR2M0qceD6fGSQhJPCJUWL6
        CQc4++o8+S5GDrCGD/fsIOp3MkosW3GODaLmGaPErX3pIDaLgKrEnTevWUDq2QS0JU7/5wAJ
        iwjoSPz7O5kFpJdZ4AaTxP4zP1hBEsICIRKznk8Em8MrYCbR+OEOC4QtKHFy5hMwm1PASeL9
        gRdMILaogIzEjKVfmUEGSQgc4ZDY2NrHDPGNi8SatiPsELawxKvjW6BsKYnP7/ayQdjlEiun
        rGCDaG5hlJh1fRYjRMJeovVUPzPI1cwCGRJ7fulDhGUlpp5aB7aYWYBPovf3EyaIOK/Ejnkw
        trLEmvULoOZLSlz73ghle0jc/3qRCRJaRxkljh07yDyBUX4WkudmIaybBbbCSqLzQxMrRFha
        Yvk/DghTU2L9Lv0FjKyrGCVTC4pz01OLTQsM81LL4ZGdnJ+7iRGcqrU8dzDeffBB7xAjEwfj
        IUYJDmYlEd7rT9NThXhTEiurUovy44tKc1KLDzGaAuNqIrOUaHI+MFvklcQbmlgamJiZmZlY
        GpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTTx8TBKdXAVLrrbmF88TnPUE436fC67l/HxP2OXSyr
        aVku+Uop4JDg0kDt11O3bVrjo2VmYWm7gN2t6H3Qt4xIn4seVZff2shMX11mOPdKG+vi+rmH
        0+ZeK5h68AX3gjVa936snbG7/k/PV3cdzXmbF9hsTdYXa5UMa17kM/2g4KOL1wUmP3fKCA0P
        LlWL4a4VUtU98/z1m0d3ZyyZfKA0xcHvuVAFY6LNs8+VcyOLdFVOKu+4P6N2zRxeFrtr7zln
        7nv20jQpLbw9pl2+yjz4QL/4VrukPlZ108KXn94953abe/RbyLINBorssvGzW7835moLL5m+
        S8yq8kRYTvrexzeD9phr8E9f/8ug8fzHHfekDK7MUmIpzkg01GIuKk4EAEV9DPBeBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXrdVIj3V4GuTvsXqu/1sFh/mtbJb
        PFrmZ3HzwE4mi5WrjzJZ7F74kcli0qFrjBZPr85isri8aw6bxfxlT9ktdjxpZLRY9/o9iwOP
        x6z7Z9k8ds66y+5x/t5GFo/LZ0s9Nq3qZPO4c20Pm8fmJfUeu282sHn0Nr9j8+jbsorR4/Mm
        uQDuKC6blNSczLLUIn27BK6My1t/sxVsl6pYc9ipgXGLSBcjB4eEgInEh3t2XYxcHEIC2xkl
        tmxvY+li5ASKS0os+3uEGcIWllj57zk7RNETRonOTc/ZQBIsAqoSd968ZgEZxCagLXH6PwdI
        WERAR+Lf38lgc5gFbjFJzH2iBmILC4RIzHo+EayVV8BMovHDHRaImUcZJVp/zmCHSAhKnJz5
        BKrZTGLe5ofMIPOZBaQllv8Dm88p4CTx/sALJhBbVEBGYsbSr8wTGAVnIemehaR7FkL3Akbm
        VYyiqQXFuem5yQWGesWJucWleel6yfm5mxjB8aUVtINx2fq/eocYmTgYDzFKcDArifDqfUxO
        FeJNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamAS+P2g4vKF
        hOKJl9viWA7buFouXqF+Xa6VZYNjO+trYcWobV9az/ztTfMJF+5z6UxruNef0chVHnS688eW
        v/+OOO+VN6l6qvH45w4T9uQOw5p+gQ8PC4v1q3j+rbLtYmowD2GpeMhxdTGL/R9W+alLNrjm
        S5pvP5SV77qgrunk85L7ulJhYfw5Uce0So/ZHnk0MU3l3+mui6+mhLB6Tb32sfdD0YfMlccc
        G5dFFD3RnST4Vkp07gMlk01zIvh2rLj4kuGOoKz+srTurgvGBaelWk+uObNRQm4at+gmLcHH
        0zXK3Pb1fgy5YrY5pbN+Dvfev9JXQ1mnXvq16NSikKIo51c6cy/G7stkilCzm6bEUpyRaKjF
        XFScCAAFdA1DHgMAAA==
X-CMS-MailID: 20231129105501epcas5p415ce4aaa65bd771d074cedaa77ef2c02
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_1a776_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231128123622epcas5p4940679fbbafdf0da802deea3e531f850
References: <CGME20231128123622epcas5p4940679fbbafdf0da802deea3e531f850@epcas5p4.samsung.com>
        <20231128122958.2235-1-nj.shetty@samsung.com>
        <0cd6862e-8037-40b3-9fde-b7f10d66e31c@suswa.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_1a776_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 29/11/23 12:26PM, Dan Carpenter wrote:
>On Tue, Nov 28, 2023 at 05:59:56PM +0530, Nitesh Shetty wrote:
>> This fixes the smatch warning, "nvme_loop_create_ctrl() warn:
>> 'opts->queue_size - 1' 18446744073709551615 can't fit into 65535
>> 'ctrl->ctrl.sqsize'"
>> We don't need size_t for queue_size, u16 should serve the purpose,
>> as max size is limited to NVMF_DEF_QUEUE_SIZE(1024).
>>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>
>Huh...  I'm sorry I wasn't necessarily aware that I had published this
>Smatch warning.  I feel like it has a high rate of false positives.
>
>Generally with Smatch warnings, I'm not going to try silence every
>false positive.  And I had one complaint recently that I was too focused
>on silencing false positives instead of discovering new bugs...
>
>The other thing about static analysis is that static checker developers
>want 0% false positives and kernel developers want 100% false positives.
>I'm a kernel developer so in code that I have looked at the rate of
>false positives is very close to 100%.  Only new code has valid
>warnings.
>
>Here is what this code looks like:
>
>drivers/nvme/target/loop.c
>   573          if (opts->queue_size > ctrl->ctrl.maxcmd) {
>   574                  /* warn if maxcmd is lower than queue_size */
>   575                  dev_warn(ctrl->ctrl.device,
>   576                          "queue_size %zu > ctrl maxcmd %u, clamping down\n",
>   577                          opts->queue_size, ctrl->ctrl.maxcmd);
>   578                  opts->queue_size = ctrl->ctrl.maxcmd;
>   579          }
>   580          ctrl->ctrl.sqsize = opts->queue_size - 1;
>
>Smatch thinks that opts->queue_size is a value that comes from the user
>in the 16-47 range.  But the bug is that Smatch thinks that
>ctrl->ctrl.maxcmd is zero.  16 is greater than zero so we do the
>opts->queue_size = ctrl->ctrl.maxcmd; assignment.  Then zero minus one
>is ULONG_MAX so that's a very high number.
>
>Smatch is just wrong in this case.  Let me try figure out what went
>wrong.  The ctrl->ctrl.maxcmd = 0 comes from:
>
>	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
>
>It's supposed to get set to unknown in nvme_loop_configure_admin_queue().
>The database has the correct data.
>
>$ smdb.py return_states nvme_loop_configure_admin_queue | grep maxcmd
>drivers/nvme/target/loop.c | nvme_loop_configure_admin_queue | 229 |             0|       PARAM_SET |  0 |       $->ctrl.maxcmd |             0-u16max |
>drivers/nvme/target/loop.c | nvme_loop_configure_admin_queue | 231 | s32min-(-1),1-s32max|       PARAM_ADD |  0 |       $->ctrl.maxcmd |             0-u16max |
>
>But the issue is that Smatch thinks that nvme_loop_configure_admin_queue()
>always fails with -12.  The reason for that is because Smatch thinks
>that ctrl->ctrl.ops is NULL but the function can only succeed when it's
>non-NULL.
>
>The ctrl->ops assignment happens in nvme_init_ctrl() and it should have
>been easy to track.  I am not sure what went wrong there.  I'll take a
>look at that and fix it.

Thank you for this insight.
I ran smatch on complete kernel using smatch's test_kernel.sh
I was unaware of this smbd.py option. I will explore this.
Meanwhile I feel this patch is still relevant, as it aligns opts
queue_size with size of ctrl queue_size.

Regards,
Nitesh Shetty

------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_1a776_
Content-Type: text/plain; charset="utf-8"


------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_1a776_--
