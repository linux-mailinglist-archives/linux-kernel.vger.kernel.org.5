Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E925774330
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjHHR63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjHHR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:58:01 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC79C1564;
        Tue,  8 Aug 2023 09:26:11 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BE33040E019E;
        Tue,  8 Aug 2023 12:10:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l7qeyE9fTRly; Tue,  8 Aug 2023 12:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691496640; bh=Yyb9lJPqZ0admMIXFo2/2Rag2tQt+j4FUnO9ttD70gk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=A1f25q4q1uJiOFvsLjYheE8rZWEX4+Q/HQszn6Oq3QZfDdsulLZwUrsiC79WRgdQ6
         kQySYNlUqLjqRUDdoquepfUO4xWaOYCNjtG2CJiM4K4ZZzWW3HGq5rOFx4rQiskxZc
         3cC9MDJ/BCqyPTC/A/bf0IeAdCkdNX0LmhhRKKfZ7d/FW8cqfXCme8TUccbT7NIUFP
         2KP9Smb5cTSGatMBihnI0DViLi9QiJ/Mo0Rqv4Oon1IkyzlzS0wwJ3MTM86zF0M7vj
         sJKWp5d0V/XZ1x/yRj4D954OK98HHQz7kux4E6cW/PHcRs3c6VsvMtj3EvwMTnt30l
         mKllBRkbwkf+I48vSIp29F/iuOf1R+FWi2Lp6cWoAaYr2xdhxqaaOOP4DFp7ZjIGKJ
         rYsno5L0eOLsJLaeifgFBXiMXEioujwr6iusUlugKSsP8M2fRUwioBMqAygMzjyRyw
         QzIM5zbKUPWwexcyLSRfOlJUYwdvAkszpT0DqVByMvqOScGX36ILFMqro2NNaHcMn7
         NiRSnxeNEvXrN8+tYQklND9Ym5OQCL7479dbskbuSJhfVxlzwvpBj543imwD7Krj5u
         Zj/fJHucjLBUmlFLguBBN5n8FTJLdJIhBOpyp8YED55iF/EYWAD8QaXJsv8TeMcK5g
         YVFnKf1OhQ85Ch03ZKa8Y8ac=
Received: from [127.0.0.1] (unknown [46.114.213.25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67A1640E0195;
        Tue,  8 Aug 2023 12:10:31 +0000 (UTC)
Date:   Tue, 08 Aug 2023 14:10:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-edac@vger.kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>
CC:     linux-kernel@vger.kernel.org, avadhut.naik@amd.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_platform/x86/amd=3A_Int?= =?US-ASCII?Q?roduce_AMD_Address_Translation_Library?=
User-Agent: K-9 Mail for Android
In-Reply-To: <894b3737-1a0a-4139-9c73-686a95481795@amd.com>
References: <20230802185504.606855-1-yazen.ghannam@amd.com> <20230802185504.606855-2-yazen.ghannam@amd.com> <58934edf-4fad-48e0-bc5d-62712b11e607@amd.com> <894b3737-1a0a-4139-9c73-686a95481795@amd.com>
Message-ID: <B3BE6B56-FBAB-4878-A45D-E95AFAC86AB1@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 8, 2023 5:17:33 AM GMT+02:00, "Limonciello, Mario" <mario=2Elimon=
ciello@amd=2Ecom> wrote:
>Given it's 'library code' to be used by a bunch of things and also want t=
o be able to use a module, what about putting it in lib/?  There's plenty o=
f library code there as tristate=2E

It is x86-specific so not in there=2E Also, it might be used by multiple t=
hings so you want it as a separate "translation" service which is called by=
 other modules=2E

Thx=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 
