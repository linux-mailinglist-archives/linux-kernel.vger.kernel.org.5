Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8069D7B0AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjI0RMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjI0RMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:12:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395BA1;
        Wed, 27 Sep 2023 10:12:18 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RHA5JD023510;
        Wed, 27 Sep 2023 17:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=qFa9jLUh+JKvJ5yXF2hdYjW1ApltXhzFVkhrDmw7/Po=;
 b=gp8vpU7BtLZUNmb4/UU5a9kSe+wj/tpO/Rg/YP8N9JNcnJPpRkd68FqhBnyHc97hQCdU
 MDYKgSn6DHgcGXPE5qFhA1prJ2dxKS3lkb//4OHLeTSgreW38fDvYLNWLvaDatGJsic6
 g+oH8wkYZ9g7EucY28XXso5GP7ZSAed/FZMoZAVJhvKeZjIX8FVfmhVvqEzx+UV2838T
 ecAWhv0VN3edlyX07DaD8oFpDDlpFtBcSd6bPssMcG1kSa+4IOypRXtBltamW6EpdDnW
 fgLXmrIDR2NgqcNFTx6p0zeAizIPeidYm7mh3CrFLXOAtW3mxRtoKGN0Vssf5pl45JJC EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcnh8wswt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 17:11:50 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RHAP6u026041;
        Wed, 27 Sep 2023 17:11:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcnh8wswm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 17:11:50 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38RGU8eo011029;
        Wed, 27 Sep 2023 17:11:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukmxwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 17:11:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RHBk1K26346166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 17:11:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 354B520049;
        Wed, 27 Sep 2023 17:11:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECDD820040;
        Wed, 27 Sep 2023 17:11:45 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 17:11:45 +0000 (GMT)
Date:   Wed, 27 Sep 2023 19:11:44 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Message-ID: <20230927191144.3fcd2f99.pasic@linux.ibm.com>
In-Reply-To: <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
        <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RxwqV5G58QNG68Eh85H-hT-muy5w6C5f
X-Proofpoint-ORIG-GUID: SFqE0SbA7I-X6qMRuKIB1WR9K-rgjWOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=829 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 18:41:58 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> > +	local_bh_disable();
> >  	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
> > +	local_bh_enable();  
> 
> Thanks Gonglei!
> 
> I did this a quick spin, and it does not seem to be sufficient on s390x.
> Which does not come as a surprise to me, because 
> 
> #define lockdep_assert_in_softirq()                                     \
> do {                                                                    \
>         WARN_ON_ONCE(__lockdep_enabled                  &&              \
>                      (!in_softirq() || in_irq() || in_nmi()));          \
> } while (0)
> 
> will still warn because  in_irq() still evaluates to true (your patch
> addresses the !in_softirq() part).
> 
> I don't have any results on x86 yet. My current understanding is that the
> virtio-pci transport code disables interrupts locally somewhere in the
> call chain (actually in vp_vring_interrupt() via spin_lock_irqsave())
> and then x86 would be fine. But I will get that verified.

[ 35.177962][ C0] WARNING: CPU: 0 PID: 152 at kernel/softirq.c:306 __local_bh_disable_ip (kernel/softirq.c:306 (discriminator 1)) 
[   35.178551][    C0] Modules linked in: vmw_vsock_virtio_transport(+) vmw_vsock_virtio_transport_common virtio_crypto(+) crypto_engine vsock
[   35.179930][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
[ 35.180548][ C0] RIP: 0010:__local_bh_disable_ip (kernel/softirq.c:306 (discriminator 1)) 
[ 35.180936][ C0] Code: eb 7d 65 8b 05 ef 90 eb 7d 31 f0 f6 c4 ff 74 13 9c 58 f6 c4 02 75 17 80 e7 02 74 01 fb 5b c3 cc cc cc cc e8 48 2f 15 00 eb e6 <0f> 0b eb ca e8 2d 88 03 03 eb e2 66 66 2e 0f 1f 84 00 00 00 00 00
All code
========
   0:	eb 7d                	jmp    0x7f
   2:	65 8b 05 ef 90 eb 7d 	mov    %gs:0x7deb90ef(%rip),%eax        # 0x7deb90f8
   9:	31 f0                	xor    %esi,%eax
   b:	f6 c4 ff             	test   $0xff,%ah
   e:	74 13                	je     0x23
  10:	9c                   	pushf
  11:	58                   	pop    %rax
  12:	f6 c4 02             	test   $0x2,%ah
  15:	75 17                	jne    0x2e
  17:	80 e7 02             	and    $0x2,%bh
  1a:	74 01                	je     0x1d
  1c:	fb                   	sti
  1d:	5b                   	pop    %rbx
  1e:	c3                   	ret
  1f:	cc                   	int3
  20:	cc                   	int3
  21:	cc                   	int3
  22:	cc                   	int3
  23:	e8 48 2f 15 00       	call   0x152f70
  28:	eb e6                	jmp    0x10
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb ca                	jmp    0xfffffffffffffff8
  2e:	e8 2d 88 03 03       	call   0x3038860
  33:	eb e2                	jmp    0x17
  35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  3c:	00 00 00 00 

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb ca                	jmp    0xffffffffffffffce
   4:	e8 2d 88 03 03       	call   0x3038836
   9:	eb e2                	jmp    0xffffffffffffffed
   b:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  12:	00 00 00 00 
[   35.182237][    C0] RSP: 0018:ffffc90000007d88 EFLAGS: 00010006
[   35.182637][    C0] RAX: 0000000080010003 RBX: ffff888108308538 RCX: ffffc90000007d50
[   35.183186][    C0] RDX: ffff88811ae36300 RSI: 0000000000000200 RDI: ffffffffc02b16cc
[   35.183700][    C0] RBP: ffff8881083084e8 R08: 0000000000000000 R09: fffffbfff0d04f04
[   35.184216][    C0] R10: ffffffff86827823 R11: ffffffff852013e6 R12: 0000000000000001
[   35.184730][    C0] R13: 0000000000000000 R14: ffff888108308538 R15: dffffc0000000000
[   35.185248][    C0] FS:  00007f06cb551800(0000) GS:ffff88811ae00000(0000) knlGS:0000000000000000
[   35.185831][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.186271][    C0] CR2: 000055dc93010628 CR3: 0000000116b28000 CR4: 00000000000006f0
[   35.186789][    C0] Call Trace:
[   35.187010][    C0]  <IRQ>
[ 35.187204][ C0] ? __warn (kernel/panic.c:673) 
[ 35.187505][ C0] ? __local_bh_disable_ip (kernel/softirq.c:306 (discriminator 1)) 
[ 35.187857][ C0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 35.188197][ C0] ? handle_bug (arch/x86/kernel/traps.c:237 (discriminator 1)) 
[ 35.188483][ C0] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 35.188790][ C0] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568) 
[ 35.189120][ C0] ? asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636) 
[ 35.189466][ C0] ? virtio_crypto_dataq_sym_callback (drivers/crypto/virtio/virtio_crypto_skcipher_algs.c:567 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c:81 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c:55) virtio_crypto
[ 35.189983][ C0] ? __local_bh_disable_ip (kernel/softirq.c:306 (discriminator 1)) 
[ 35.190336][ C0] virtio_crypto_dataq_sym_callback (drivers/crypto/virtio/virtio_crypto_skcipher_algs.c:570 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c:81 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c:55) virtio_crypto
[ 35.190837][ C0] virtcrypto_dataq_callback (drivers/crypto/virtio/virtio_crypto_core.c:91) virtio_crypto
[ 35.191304][ C0] ? __pfx_virtcrypto_dataq_callback (drivers/crypto/virtio/virtio_crypto_core.c:76) virtio_crypto
[ 35.191796][ C0] ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:113) 
[ 35.192154][ C0] vring_interrupt (drivers/virtio/virtio_ring.c:2598) 
[ 35.192536][ C0] vp_vring_interrupt (drivers/virtio/virtio_pci_common.c:67 (discriminator 2)) 
[ 35.193064][ C0] ? __pfx_vp_vring_interrupt (drivers/virtio/virtio_pci_common.c:60) 
[ 35.193793][ C0] __handle_irq_event_percpu (kernel/irq/handle.c:158) 
[ 35.194272][ C0] handle_irq_event (kernel/irq/handle.c:195 kernel/irq/handle.c:210) 
[ 35.194587][ C0] handle_edge_irq (kernel/irq/chip.c:833) 
[ 35.194903][ C0] __common_interrupt (arch/x86/kernel/irq.c:271) 
[ 35.195232][ C0] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 47)) 

So I was wrong, this patch is not sufficient, not on x86 nor on s390x.
And the problem is that we are in hardirq context.

For some reason, I was under the impression that disabling interrupts in
a hardirq context somehow takes you out of hardirq context and makes
in_irq() return false. Silly me! (I was assuming the fix works on x86 and
hallucinated based on that assumption and any differences I have found
between virtio-ccw and virtio-pci.)

Currently I don't see a need to fix anything in virtio-ccw.

Regards,
Halil


