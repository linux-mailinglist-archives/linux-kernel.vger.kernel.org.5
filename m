Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E02A7B5DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbjJBXkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjJBXkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:40:11 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BDB8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1696290004; x=1696549204;
        bh=6DHdQbMvIWC+d7DLpgr//TLkTz6cWUQ8snqb9evmiZk=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Y+TqzzD5G/+tu+YT+M5KZPXY0Jl900r1zX14HHdruI6VzYTerMctm6oL2w/e3jdmM
         nqo6J8DI2R0p0T6Ksj+bU30N4hDRUlbH7An5e+URedItk/07fyI00qTL9yD4bSK9bB
         hx2I54A20wPLEF5FiBVek26Wjwz6bI5YknDPE385VcsjV9b8nyCc+aq5OM9HtOK0bB
         j/ejWpx3aKBPkDmfJ/bJCko1BZ/5+ZUYHP328kIXiRYQkXS2sBfnuAova/qgiVRzbI
         3RX99tcKAWkpI69XilgFqf5PwY/ma9IQzdzTFdWZBlVMAe8yfB7L+aRSuBW/tcrLMj
         F1iq1hTuzU5uQ==
Date:   Mon, 02 Oct 2023 23:39:55 +0000
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Michael Pratt <mcpratt@protonmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rafal Milecki <zajec5@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v1 0/2] mac_pton: support more MAC address formats
Message-ID: <20231002233946.16703-1-mcpratt@protonmail.com>
Feedback-ID: 27397386:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, mac_pton() strictly requires the standard ASCII MAC address form=
at
with colons as the delimiter, however,
some hardware vendors don't store the address like that.

If there is no delimiter, one could use strtoul()
but that would leave out important checks to make sure
that each character in the string is hexadecimal.

This series adds support for other delimiters
and lack of any delimiter to the mac_pton() function.

Tested with Openwrt on a MIPS system (ar9344).



