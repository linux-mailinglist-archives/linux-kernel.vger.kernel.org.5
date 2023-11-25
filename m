Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD87F8D9F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjKYTGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYTGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:06:50 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A289F1;
        Sat, 25 Nov 2023 11:06:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700939208; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=c0iqwX+9WViNTos0ONMkw6hHVD+swHKuJ/MY6sfol262oHkMJrJIygLv/0RkXXYxRCd7hSP7L5visPq8OqssdcgWzmrY5QyHqny2WbaqPR1KRrGdgq/jb5nELBqWWXO/Yy24Uxk+/ui32anWPUlenesR2LvYayT0XxTEiodB72I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1700939208; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=Kjy5h53YNBfRPMZkuD1hYHLFz0/HrabUBTJReH2mQpU=; 
        b=OfrrSf+rGqoog5SYAmftgjqrj5LVItOTkrjCeqNlRwf7az+brvTi8bmFJUUYFTSn6Rb1EqGAV4RJ5m+8MtCmTRO8XgSVZZXVLMmf1CZR6tAzFnEcHSzORgo6za/+Cff0cVTkMFdrf75MaZ04udv0LdN3bcUcwPNfZIyomkfHHs4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700939208;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Kjy5h53YNBfRPMZkuD1hYHLFz0/HrabUBTJReH2mQpU=;
        b=A+pqDO9IlsZ3IL+KhevF+swP+v+nT0vypBKBWC8lym/VPxLIl2IpAoS1QC0bmkPX
        PcoR/evOPiy+i/2mcQLwIJoRxb4Xx4niDfLfG64rI9CDswn1tgX3+Mi4tIq4XZ4ARc7
        BPVKf9CmfAofcMlesV9G/JTcIrEWtsvxL23L/PKo=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 170093917663875.992804182481; Sun, 26 Nov 2023 00:36:16 +0530 (IST)
Date:   Sun, 26 Nov 2023 00:36:16 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "syzbot" <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "netdev" <netdev@vger.kernel.org>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <18c07e01a4c.220c832d175971.1254981088507972317@siddh.me>
In-Reply-To: <000000000000ee78fb060afe9767@google.com>
References: <000000000000ee78fb060afe9767@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test final changes

#syz test https://github.com/siddhpant/linux.git lock
