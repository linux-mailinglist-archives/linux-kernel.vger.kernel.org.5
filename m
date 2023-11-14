Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6FA7EB6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjKNTlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNTlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:41:18 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2C107;
        Tue, 14 Nov 2023 11:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=y2B2n6o5s66GYrU/6AX0x5LJjn5iab4+r1wbNLKGJjY=; b=YoGJ91uXtsqo8U8+OXPAkv2Npm
        3ZXQhG6dF55DNdRW8PFBg61JFf6biewmuldFciGlX5sjN1t1RnUVXBeGWFTQgqjiA9Jvn4Z9VqPeC
        W29NJEX1T9oSnux71BmIcNf+nReGgiqk0B5QcaQSZFhA0sN1M7QlepXeSY8PckJLJHbgfVqknwatF
        xWSjujNHqcYDX7KRiICFmGO8OrS1JfoIPFHVU+yF9WpgfY21FTO3Lx9CmpXnfNHGhIiML7HtWNgeV
        WzZ/bqDmo48ITwgsWrfsDKtbvl+Mae4D4cw8ancrHlbl5JQ4w8ECEwB7Gc2Q3F+61hpSsOlZo980r
        maeMV6Fw==;
Received: from [12.186.190.2] (helo=[127.0.0.1])
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r2zHY-002g7X-38;
        Tue, 14 Nov 2023 19:41:09 +0000
Date:   Tue, 14 Nov 2023 14:41:03 -0500
From:   David Woodhouse <dwmw2@infradead.org>
To:     Sean Christopherson <seanjc@google.com>,
        Dongli Zhang <dongli.zhang@oracle.com>
CC:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_KVM=3A_x86=3A_Don=27t_unnecessarily?= =?US-ASCII?Q?_force_masterclock_update_on_vCPU_hotplug?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZVPM-8MKW56hHCuw@google.com>
References: <20231018195638.1898375-1-seanjc@google.com> <e8002e94-33c5-617c-e951-42cd76666fad@oracle.com> <0e27a686-43f9-5120-5097-3fd99982df62@oracle.com> <ZVPM-8MKW56hHCuw@google.com>
Message-ID: <380C83F0-5F0D-4B30-9E5C-F0DB9FDED44B@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 November 2023 14:39:39 GMT-05:00, Sean Christopherson <seanjc@google=
=2Ecom> wrote:
> timing doesn't really matter in the end=2E

No pun intended?=20

