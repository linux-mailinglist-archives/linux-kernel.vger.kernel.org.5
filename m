Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89977AF429
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjIZTag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjIZTae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:30:34 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8261A8;
        Tue, 26 Sep 2023 12:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695756622; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=lwoL+BJ63ZMJqJTTpGJQvmfAHO1C6bL2bi5NVVqrCgBuxuJebziZHTIBecPUPuEXDlSzpLqSRqlVuRnP6MZ4CT871d9obbravnkfWhF4+QwiJx72cQqzgiX43r5fJz7PgygHIOr8Db7c3OX3maLahyVEqk+fKsHIzjb4mvIVi/U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1695756622; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=IHp47SZZhOVX7RgfWbEW1pr9ONVR0CNEitbtqrTGu0w=; 
        b=dRUf/FCAUBrR4Y11/sV64SIGLvUcBSSkJ9rRfdJCQenVTyJS+jqvdEzFrWke4MSRPpg83qVaAE0heOHExI23KWXJx4bLcJkaAR5qq/67pesZhJJuxpd7scV6b1K5+K26vwYV/XiOywdKSxtDie0epgG4nyVlWySXCO7q8vS1erU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=marliere.net;
        spf=pass  smtp.mailfrom=ricardo@marliere.net;
        dmarc=pass header.from=<ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695756622;
        s=zmail; d=marliere.net; i=ricardo@marliere.net;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=IHp47SZZhOVX7RgfWbEW1pr9ONVR0CNEitbtqrTGu0w=;
        b=uXhg1rBJVWZBy5qVy54merY5FPGGGEEES0FAt12BXv1BOhqnwFkedZNmERzs3Z0F
        HgYTo3ztImPrfy2Vy7lxYj5UpbpFlbB4w9j9M34VQmJO+1u8s0gGosT+i8WofzVJfYG
        3DpqwWS4GTC/UlUA1LYqwy2/9a2Btq5epSTm1og4=
Received: from localhost (177.104.93.54 [177.104.93.54]) by mx.zohomail.com
        with SMTPS id 1695756620946934.3928532457957; Tue, 26 Sep 2023 12:30:20 -0700 (PDT)
Date:   Tue, 26 Sep 2023 16:30:24 -0300
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     syzbot <syzbot+1c41b2e045dc086f58be@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, sean@mess.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] [media?] WARNING in imon_probe
Message-ID: <frvhx2mz7zjozlpcrtk3u4e4xarm4mpzqpq6ldrizrw5a4bywb@vqxbfi4ebvul>
References: <mrce6emi7jvmoe4fgxt7lgrgkswkinc5u3hpl57gr5oaxau55o@fdvuaqxcsgu6>
 <000000000000bedf08060647e102@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000bedf08060647e102@google.com>
X-ZohoMailClient: External
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: KASAN: slab-out-of-bounds Read in imon_probe
