Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75C8805B7C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345252AbjLERFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345170AbjLERFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:05:41 -0500
X-Greylist: delayed 9602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 09:05:45 PST
Received: from 8.mo580.mail-out.ovh.net (8.mo580.mail-out.ovh.net [46.105.52.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8836AA1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:05:45 -0800 (PST)
Received: from mxplan8.mail.ovh.net (unknown [10.109.146.96])
        by mo580.mail-out.ovh.net (Postfix) with ESMTPS id 597382435D;
        Tue,  5 Dec 2023 14:00:19 +0000 (UTC)
Received: from piedallu.me (37.59.142.107) by mxplan8.mail.ovh.net
 (172.16.2.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Dec
 2023 15:00:18 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-107S001432695c8-33c5-4fb7-8a7c-d9542a815873,
                    74C7C1992E4F488363DD529DEE5BA00C4ED99BDC) smtp.auth=postmaster@piedallu.me
X-OVh-ClientIp: 176.169.226.152
Received: from salamandar.fr.lan (unknown [45.81.62.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by piedallu.me (Postfix) with ESMTPSA id 1E2D06004D;
        Tue,  5 Dec 2023 11:20:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=piedallu.me;
        s=mailkey; t=1701771640;
        bh=36C+DjkFIsZAsYt7V6sqOaJ1IjI6J30mM0cjv7+1rp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AVQE/6Lk6PxoJp0M8anlRYtH5KL8G4nGt2f2ZRWwMVWelpNc/e3miIK30qRW2KEzP
         Fj2UVI33nmAbgBjUa4THc9dKo86FKXftxKGZp3p+vGGLGWA4ts3UQMk0wX1R++i4yj
         UKHjfPsj03oDLFVTYbBgC92XG5alQIXAvsMOxqko=
From:   =?UTF-8?q?F=C3=A9lix=20Pi=C3=A9dallu?= <felix@piedallu.me>
To:     andrew@lunn.ch
Cc:     davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com,
        ramon.nordin.rodriguez@ferroamp.se
Subject: 
Date:   Tue,  5 Dec 2023 11:20:39 +0100
Message-ID: <20231205102039.2917039-1-felix@piedallu.me>
In-Reply-To: <f25ed798-e116-4f6f-ad3c-5060c7d540d0@lunn.ch>
References: <f25ed798-e116-4f6f-ad3c-5060c7d540d0@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-GUID: d137995d-c8aa-4c45-9d08-67be1aa9503b
X-Ovh-Tracer-Id: 3238932558428276914
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 10
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucfgmhhpthihuchsuhgsjhgvtghtucdluddtmdenucfjughrpefhvfevufffkfgjfhggtgfgsehtkeertddttdejnecuhfhrohhmpefhrohlihigucfrihoruggrlhhluhcuoehfvghlihigsehpihgvuggrlhhluhdrmhgvqeenucggtffrrghtthgvrhhnpeffteegleduieefleeigeeuueettdelteegheehvdeuleekveduteegkeekgeevvdenucffohhmrghinhepmhhitghrohgthhhiphdrtghomhenucfkpheptddrtddrtddrtddpudejiedrudeiledrvddviedrudehvddpgeehrdekuddriedvrddujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnkedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehfvghlihigsehpihgvuggrlhhluhdrmhgvpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedt
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [PATCH 2/3] net: microchip_t1s: add support for LAN867x Rev.C1

Hi, 

> So there is a gap in the revisions. Maybe a B2 exists?

Actually, probably not. Some search gives this datasheet:

https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/DataSheets/LAN8670-1-2-Data-Sheet-60001573.pdf

And page 2 (table 1) shows only revisions A0 (rev0), B1, (rev2), C1 (rev4).
Not sure about why only even revision numbers are released ?

Page 193 (table 10-1) also shows only B1 and C1. So you can be confident that only those exist.

@Ramón, thank you for your work on this driver!

Félix Piédallu
