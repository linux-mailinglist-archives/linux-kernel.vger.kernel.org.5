Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55AF7FB0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbjK1ENS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjK1ENQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:13:16 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1041A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:13:22 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cd8579096eso2116504b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rumble.com; s=google; t=1701144801; x=1701749601; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fqhHAk89pIlNcOsjPfSLqDQP5PKbPvbo9QQCVb/jFEk=;
        b=OtsGktFQFHOJkD9YS30veECusKsgKRgwIciq06mO/ixIUecNUIOW4wGpRzqN2UYKwm
         nWCSkXQv6jQUAtfEPqZtVr0bhUxhTllD0R9g7MnVmRNi+lTVbLmV+oaKm+/F9j8cVJgn
         97iv4YnjCQXLUWCf2Q4NHiCJ9RObx8mbnKv+I5rxz29iaDmVoHt6KbqJjbaEXXEbYNOY
         TJ9EqBlPT30LzZRoI9sAHwLjL10+UTk8WIKlds/Gj62oZayXnKZNNsY2u8uzDfPkRztB
         af/H+ESijzkmEFsll/jfCVtNZNEhq4cw2+1B0dBFEEZYZDmzH0++nV4vsFh55G5jucxN
         fOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701144801; x=1701749601;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqhHAk89pIlNcOsjPfSLqDQP5PKbPvbo9QQCVb/jFEk=;
        b=tdfSBrUNqqzbc5tnF3Cbpp47EdGdRnTY/y8eYp8BNoifkwehx7M7cI2Bo7wnbU7zlj
         UyXDJo+dO3yB2GrwFpn30nDnrne4kuwAWwnbYnZ9WqIwbs+xzqg9M0CW+KhSpSKTs8H9
         HVatnUQ1uoZVtL4Q6s8qLxoY6/Gp8adgVnS8qL73s0K+GXij2na5Ha4fMxGEhcQaiPV8
         20CDmsuhpiWQf5L2bNABEyu+Z5At7N6RnJt/3BjoEz3D34x9lqtY+Sl0kirxygncYuRV
         78i4ZKj7/xdPrkuID7IxN5Lj02gSuvlHODL4yho5JHnmsdGXwCOh2HI1784egQ++GCDC
         ViEw==
X-Gm-Message-State: AOJu0Yy05ZgKIa9Yc445O/NKsLjeo+yUSHtcyEls/9tbDN1UuYeULYkq
        1v8zuwpnu/KvHo+l8LtCZY/bW3l2sm+78OZkn5XTXg==
X-Google-Smtp-Source: AGHT+IGcspGxT2+hMUuKSggPa1zmk7/DIzD9QMyusXyeFEA8fDsov5+w2VzGbuw+HTYb3AF1V3kghw==
X-Received: by 2002:a05:6a00:807:b0:6cb:910a:c6fe with SMTP id m7-20020a056a00080700b006cb910ac6femr21788994pfk.7.1701144800903;
        Mon, 27 Nov 2023 20:13:20 -0800 (PST)
Received: from smtpclient.apple (pool-74-102-70-128.nwrknj.fios.verizon.net. [74.102.70.128])
        by smtp.gmail.com with ESMTPSA id j26-20020a62b61a000000b006cbb7e27091sm8222892pff.175.2023.11.27.20.13.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2023 20:13:20 -0800 (PST)
From:   Jay Rhine <jay.rhine@rumble.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Possible Kernel Bug caused by NAT in Open vSwitch
Message-Id: <2025D37F-BFCB-47DB-BA22-A8CD56AB3380@rumble.com>
Date:   Mon, 27 Nov 2023 23:13:08 -0500
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!=20

I=E2=80=99m hoping that you can help me got to the bottom of what =
appears to be a Kernel Bug that I have been seeing recently.
I have been experiencing system crashes on multiple x86_64 systems =
running Open vSwitch on Ubuntu 22.04 with kernel version =
5.15.0-89-generic #99-Ubuntu SMP. This is the latest generic Ubuntu =
22.04 kernel at this time. When this crash occurs, I see the following =
error message in journalctl, but we get nothing on the console or logged =
anywhere else, and just a complete system freeze:

Nov 26 06:56:34 system_name kernel: ------------[ cut here ]------------
Nov 26 06:56:34 system_name kernel: kernel BUG at =
net/core/skbuff.c:1697!
-- Boot f90d566815cb4044bc7cbc8703a7aa9e --
Nov 26 07:22:32 system_name kernel:

I cannot reliably reproduce the issue on a test system. However, when it =
does occur it seems to be directly correlated with traffic using NAT =
through Open vSwitch on these servers. It is not as simple as just =
putting any traffic through the NAT, so it must be related to something =
more subtle (a specific type of traffic, header, etc.). This issue =
occurred multiple time on at least 6 separate servers, so it is not =
related to a hardwares issue.

Unfortunately, the error message above does not provide much in the way =
of details (no stack trace, etc). So I pulled down the latest kernel =
source code specifically for this version of the ubuntu kernel, and it =
appears that this =E2=80=9Ckernel BUG=E2=80=9D message is originating =
from call to =E2=80=9CBUG_ON(skb_shared(skb));" in the =E2=80=9Cint =
pskb_expand_head" function in the =E2=80=9Cnet/core/skbuff.c" file.

Here is the beginning of the function in context:

int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
                     gfp_t gfp_mask)
{
        int i, osize =3D skb_end_offset(skb);
        int size =3D osize + nhead + ntail;
        long off;
        u8 *data;

        BUG_ON(nhead < 0);

        BUG_ON(skb_shared(skb)); // THIS IS LINE 1697

        size =3D SKB_DATA_ALIGN(size);

        if (skb_pfmemalloc(skb))
                gfp_mask |=3D __GFP_MEMALLOC;
        data =3D kmalloc_reserve(size + SKB_DATA_ALIGN(sizeof(struct =
skb_shared_info)),
                               gfp_mask, NUMA_NO_NODE, NULL);

Looking at =E2=80=9Cskb_shared=E2=80=9D, it will only fail if =
&skb->users has anything other than one user connect to it. Here is that =
function:

/**
 *      skb_shared - is the buffer shared
 *      @skb: buffer to check
 *
 *      Returns true if more than one person has a reference to this
 *      buffer.
 */
static inline int skb_shared(const struct sk_buff *skb)
{
        return refcount_read(&skb->users) !=3D 1;
}

Based on the above tracing through of the kernel code, I believe this =
implies that the kernel is crashing because somehow an sk_buff struct is =
being passed around with too many references.   Since this is highly =
correlated with NAT being done by OVS, I suspect the issue could be =
caused by something in the =E2=80=9Cnet/openvswitch/conntrack.c" file.  =
I did confirm that this file will indirectly call pskb_expand_head, but =
there was nothing obvious to me in the file that indicated it was not =
correctly incrementing or decrementing the references in the sk_buff.=20

I would really like to add a few debug statements in around this issue =
and recompile the kernel, but since I can=E2=80=99t reliable reproduce =
the issue when I want to I am unable to trigger the issue on a test =
machine to do that. =20

If anyone has seen this issue or anything like it and can provide any =
thoughts, suggestions, etc., I would really appreciate it.

Thank you!

Jay Rhine=
