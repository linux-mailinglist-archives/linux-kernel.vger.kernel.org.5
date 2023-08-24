Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B46786D28
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbjHXKwu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Aug 2023 06:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbjHXKwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:52:22 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A73510DA;
        Thu, 24 Aug 2023 03:52:17 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,195,1684771200"; 
   d="scan'208";a="88368780"
From:   sparkhuang <huangshaobo3@xiaomi.com>
To:     <tglx@linutronix.de>
CC:     <bhelgaas@google.com>, <chenwei29@xiaomi.com>,
        <darwi@linutronix.de>, <huangshaobo3@xiaomi.com>, <jgg@ziepe.ca>,
        <kevin.tian@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <weipengliang@xiaomi.com>,
        <wengjinfei@xiaomi.com>
Subject: Re: Subject: [PATCH] pci/msi: remove redundant calculation in msi_setup_msi_desc
Date:   Thu, 24 Aug 2023 03:52:14 -0700
Message-ID: <1692874334-39255-1-git-send-email-huangshaobo3@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <87o7iwdd67.ffs@tglx>
References: <87o7iwdd67.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.237.8.22]
X-ClientProxiedBy: BJ-MBX16.mioffice.cn (10.237.8.136) To BJ-MBX01.mioffice.cn
 (10.237.8.121)
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 11:04:16 +0200, Thomas Gleixner wrote:
> On Thu, Aug 24 2023 at 00:27, huangshaobo3@xiaomi.com wrote:
> > On Wed, 23 Aug 2023 16:15:27 +0200, Thomas Gleixner wrote:
> >> I'm not seeing what this solves:
> >
> >> > -       if (control & PCI_MSI_FLAGS_64BIT)
> >> > +       if (desc.pci.msi_attrib.is_64)
> >
> >> Both variants resolve to a test of a bit and a conditional instruction
> >> on the result. It's exactly zero difference in terms of "calculation".
> >
> >> So all this does is change the memory location to test. Not more not
> >> less. It does not generate better code and does not save anything.
> >
> > It may not be appropriate to write to eliminate duplicate calculations,
> > can it be proposed again with clean code?
>
> What's wrong with the existing code?

There is nothing wrong with the current code,
using desc.pci.msi_attrib.is_64 does not solve any problems,
thank you very much for reviewing comments.

Thanks,
sparkhuang
#/******���ʼ����丽������С�׹�˾�ı�����Ϣ�������ڷ��͸������ַ���г��ĸ��˻�Ⱥ�顣��ֹ�κ����������κ���ʽʹ�ã�������������ȫ���򲿷ֵ�й¶�����ơ���ɢ�������ʼ��е���Ϣ������������˱��ʼ������������绰���ʼ�֪ͨ�����˲�ɾ�����ʼ��� This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
