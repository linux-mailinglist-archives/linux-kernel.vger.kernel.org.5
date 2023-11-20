Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4657C7F1529
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjKTODq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjKTODZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:03:25 -0500
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9AF19B9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:02:56 -0800 (PST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1r54rW-00092I-TH
        for linux-kernel@vger.kernel.org; Mon, 20 Nov 2023 15:02:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?J=C3=B6rg-Volker_Peetz?= <jvpeetz@web.de>
Subject: ext4 bug?
Date:   Mon, 20 Nov 2023 15:02:50 +0100
Message-ID: <57a8bd86-f6b2-460f-b5c9-83e4ddd3d9cb@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla Thunderbird
Cc:     Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>
Content-Language: en-US
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
some files got there modification timestamp changed to 'Sun  6 Jan 16:04:34 CET 
2109' out of a blue. One directory has modification time stamp 'Sun  6 Jan 
15:40:00 CET 2109' and three files have 'Sun  6 Jan 16:01:22 CET 2109', 'Sun  6 
Jan 16:04:20 CET 2109', and 'Sun  6 Jan 12:56:02 CET 2109'.
This was observed recently during a backup. A check with
   find /usr -newermt 2023-11-21
found several (ca. 30) files and directories in '/usr', '/var', and in another 
partition '/home'. About 14 of the files are 'index.db' in '/var/cache/man'
This is a server running kernel 6.6.1 when this happened.
I have no clue why that happened and no idea how to reproduce.
What could cause this?

Regards,
Jörg.

