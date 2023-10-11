Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A607C6096
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjJKWuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjJKWuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:50:32 -0400
Received: from out28-42.mail.aliyun.com (out28-42.mail.aliyun.com [115.124.28.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1AFCA;
        Wed, 11 Oct 2023 15:50:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06699942|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.122276-0.000442222-0.877282;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.UykMNoQ_1697064625;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.UykMNoQ_1697064625)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 06:50:27 +0800
Date:   Thu, 12 Oct 2023 06:50:27 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.57
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
In-Reply-To: <2023101003-ointment-overstay-26d2@gregkh>
References: <2023101003-ointment-overstay-26d2@gregkh>
Message-Id: <20231012065025.ED4C.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I'm announcing the release of the 6.1.57 kernel.
> 
> All users of the 6.1 kernel series must upgrade.
> 
> The updated 6.1.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

a warn of 'make bzImage' happened in 6.1.57, but not happen on 6.1.56.

/usr/bin/make -s 'HOSTCFLAGS=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches   -m64 -mtune=generic' 'HOSTLDFLAGS=-Wl,-z,relro ' ARCH=x86_64 'KCFLAGS= ' WITH_GCOV=0 -j80 bzImage
arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
arch/x86/tools/insn_decoder_test: warning: ffffffff81076309:    f3 43                   repz rex.XB
arch/x86/tools/insn_decoder_test: warning: objdump says 2 bytes, but insn_get_length() says 4
arch/x86/tools/insn_decoder_test: warning: Decoded and checked 5528143 instructions with 1 failures


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/10/12


