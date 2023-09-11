Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2179A45F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjIKHXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjIKHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:23:48 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA5CCCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:23:41 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230911072330epoutp03033256a6fc6079e72658622362bc8b6c~Dx0sZHk4H2969029690epoutp03w
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:23:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230911072330epoutp03033256a6fc6079e72658622362bc8b6c~Dx0sZHk4H2969029690epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694417010;
        bh=0cqbyRFCKmi63OyNBNtFjoSfHRsW9qWhqCUBZfMBOno=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=W3lOuursiRImtUIpyQHjsuP24XSiivngCgRNRgfqmZPDXUA1JXAzAHMNgxG1P5/pc
         pq5oDx6t/8/V9RcOEYYwudIfiZELUJYzUHTHau6V5OSpuwVDAzP+qpDNk9Vvvt2WEy
         ml/cjrPyqYv08dlw7tMxqGqMTrHCyA4DUvB5ZNP8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230911072329epcas2p320ee0d429530e82330a979ebd64617bb~Dx0rxLGC32211322113epcas2p3M;
        Mon, 11 Sep 2023 07:23:29 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RkdVS6s8yz4x9Py; Mon, 11 Sep
        2023 07:23:28 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.0B.09693.070CEF46; Mon, 11 Sep 2023 16:23:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230911072328epcas2p448317f3bb857c6007b79beebb3de9192~Dx0qy_t-l1593215932epcas2p4G;
        Mon, 11 Sep 2023 07:23:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230911072328epsmtrp130d2e9168973998081b7046cd86fab7e~Dx0qx4PDe1933019330epsmtrp1I;
        Mon, 11 Sep 2023 07:23:28 +0000 (GMT)
X-AuditID: b6c32a45-abbfd700000025dd-35-64fec070c8bf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.65.08788.070CEF46; Mon, 11 Sep 2023 16:23:28 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.38.105]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230911072328epsmtip147c4de304029c1b04799bf8edb0e1ada~Dx0qfrseL0806708067epsmtip1p;
        Mon, 11 Sep 2023 07:23:28 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Adrian Hunter'" <adrian.hunter@intel.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>, <beanhuo@micron.com>,
        <sc.suh@samsung.com>, <hy50.seo@samsung.com>,
        <sh425.lee@samsung.com>, <kwangwon.min@samsung.com>,
        <junwoo80.lee@samsung.com>, <wkon.kim@samsung.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>
In-Reply-To: <fc40e4f8-6e84-9fbf-e2ca-87330c25c52a@intel.com>
Subject: RE: [RESEND PATCH v3 0/2] change UIC command handling
Date:   Mon, 11 Sep 2023 16:23:28 +0900
Message-ID: <000601d9e480$dc0ebb00$942c3100$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQIwe0l2XHSCkaXhuPDRLLuGM/RalAHEhVGBAhaVcJgBqZylIwKkta+hAXHHmqUB3zC/568MNyXg
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmmW7BgX8pBouvmlicfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBabL31jceD3uHzF22PxnpdMHhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfR
        fqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0z
        B+h4JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGB
        kSlQYUJ2xvqWVpaCeSwVf7esY2lg3MDcxcjJISFgIrH/0hcgm4tDSGAHo8SvtX2MEM4nRomZ
        ux6wQTjfGCW6z98HKuMAazm1LBIivpdR4vnDPVBFLxkltny+yA4yl01AW2Law92sILaIgL7E
        hv13wHYwC3QxS6y/94oFJMEpYCsx4fpLdpCpwgJ2Evd3yIGYLAKqEn+ORINU8ApYSsw+8JEV
        whaUODnzCVgnM9D4ZQtfQ72gIPHz6TJWiLiIxOzONmaItVES/7f9ZoWoecEhsfSUK4TtInF7
        8WeouLDEq+Nb2CFsKYmX/W3sED9mS+xZKAYRrpBYPO0tC4RtLDHrWTsjSAmzgKbE+l36ENXK
        EkduQR3GJ9Fx+C/UEF6JjjYhiEZliV+TJjNC2JISM2/eYZ/AqDQLyVuzkLw1C8krsxB2LWBk
        WcUollpQnJueWmxUYAiP6OT83E2M4DSt5bqDcfLbD3qHGJk4GA8xSnAwK4nwlhz6myLEm5JY
        WZValB9fVJqTWnyI0RQYzhOZpUST84GZIq8k3tDE0sDEzMzQ3MjUwFxJnPde69wUIYH0xJLU
        7NTUgtQimD4mDk6pBqbk6kmOz5u3qvcGsZTLPnfXZWE88UO6g19x0vymrJ0zTJMDtpfmiArL
        yO+75LVjnnlf7I0fjpomUYfyG5atqpH5f0r4qfed2qV+H10spNTWPLdfLaKR8EyeK0I4OTMh
        R1TkzKtsxYT3r10jfCQfP89+fZH1iOTFT9d0JIOezOq0SZt+3OiD1C4fmwP/2JgXvtNb8Zyj
        bHqLrfKrD9OzcsO2lCSuXTSLTYfpSk5oTzovT98SHWV7XQd5n7qbn44mMF86KB8n3b00at3k
        tenF+UUerp8VO4u2zXjXZHzAUsyPm4dLd4rQB+uFHKcsjp089jTgeVJ4OPsfs/97v7L/C/hn
        WdvgxqJ5jr8l7XClEktxRqKhFnNRcSIA8YB39VwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSnG7BgX8pBh/bhS1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2slhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFovNl76xOPB7XL7i7bF4z0smjwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNo
        P9DNFMARxWWTkpqTWZZapG+XwJXx++hO1oL5LBUT/+Y3MK5n7mLk4JAQMJE4tSyyi5GLQ0hg
        N6PEjs5F7F2MnEBxSYkTO58zQtjCEvdbjrBCFD1nlPjy7T9YEZuAtsS0h7tZQWwRAX2JDfvv
        MIMUMQvMYpZYuHY1WEJI4D2TxMYmHhCbU8BWYsL1l+wgm4UF7CTu75ADMVkEVCX+HIkGqeAV
        sJSYfeAjK4QtKHFy5hMWEJsZaFXvw1ZGGHvZwtfMELcpSPx8uowVIi4iMbuzjRninCiJ/9t+
        s05gFJ6FZNQsJKNmIRk1C0n7AkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwVGr
        pbWDcc+qD3qHGJk4GA8xSnAwK4nwlhz6myLEm5JYWZValB9fVJqTWnyIUZqDRUmc99vr3hQh
        gfTEktTs1NSC1CKYLBMHp1QDU17hGaGtnLOkloR+fLL4anTQpSn7ZzW+af+Vty7YZU1ngXaH
        4nKfLd5CX1ZOuvTecAEv06Sb7dc3Nr3oWjP/8fN4Bb+Pyz4Lvcm8VJG2++L2XVuCYlwzj20q
        WWEln7orsnHlnVvZ8Wtb+DTnln6TFpvh76KcbDntcPs05//7Op9GpJnqbnFlsmBcO3duqtUE
        rulO/22fSanVzanonzFrphSHVMtz1++/mjzqBY//jo+w3TH/284dN4MZJip/bZj650S2fgCn
        pmRu5PubrJ/r5jGsfxdXkjJnmVtViMpOYblZU/pmnZlX4PHmvXqNYsMVqxqvikm/+oMu/OSc
        Jzbx1WKbLXHl3qU3cnz7Dke4NyixFGckGmoxFxUnAgC4WdzRSQMAAA==
X-CMS-MailID: 20230911072328epcas2p448317f3bb857c6007b79beebb3de9192
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3
References: <CGME20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3@epcas2p3.samsung.com>
        <cover.1693790060.git.kwmad.kim@samsung.com>
        <yq1jzt5j5go.fsf@ca-mkp.ca.oracle.com>
        <02b701d9e450$3e7d5ca0$bb7815e0$@samsung.com>
        <7dc56344-ee1c-43d4-9751-ded8f76d5852@intel.com>
        <001001d9e479$ac74c5d0$055e5170$@samsung.com>
        <fc40e4f8-6e84-9fbf-e2ca-87330c25c52a@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command
> > *cmd) ..
> >         bool reenable_intr =3D false;
> >
> >         mutex_lock(&hba->uic_cmd_mutex); <<<<
>=20
> It is OK to schedule while holding a mutex.  Are you sure this is the
> problem?

Ah, I mis-understood it. It was for not applying this.
https://lore.kernel.org/linux-scsi/782ba5f26f0a96e58d85dff50751787d2d2a6b2b=
.1693790060.git.kwmad.kim=40samsung.com/

So this patch set has no problem. Sorry for bothering all of you.

Thanks.


