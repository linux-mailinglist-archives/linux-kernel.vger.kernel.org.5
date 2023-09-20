Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F457A833A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjITNYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjITNYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:24:18 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A039E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:24:11 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C76E640E014B;
        Wed, 20 Sep 2023 13:24:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GHQ-TslXAbQ5; Wed, 20 Sep 2023 13:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695216245; bh=ZMbp5HTqzRJSg8VsgOW6uuoByeuTCjNSPL9JeNv0S6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTsmLHl2DtuxJSHyDbZmTJPz0AY1KEpWsPP1mk+/9JpdDf8IIN6xBpLHFRlsuv52g
         Ev3aM1pWWtuCxBdBniFMjw9TJAVd98eZOfbsW9gYWtsEaVBa3g+CPeobzpCRgJMVOF
         N6rq4MEf5MfOAuE9ooWuOeHeV00jD6AFqENBrCRc04JW9qEZ2dkWSS2nNw0Ju8EUtj
         yC2LKvRUw9m7+46fqEYweYzpMuVX8RBkL2QsjINodrAhRGrubpFgG0+R5EtnqGfA2m
         0d8/wAo9HpEzrS+3wiFLxY1tgFShdy9Qazvim05PKTRn9u7u4QIU3aEm4pWwVvmNwR
         Yz9OSvyi5XSE2tALrxmhIvOhth0yHwJELx5/K1CJzxygu6hJRIZVTEpeDrDaVp37wr
         29PORG+0dxSuOlk2Zi6K/Eu6ijJht3Jeo3osovrus6uST080FTAWl21oIlkblwKbGm
         YZ6zQaATvM8tUa+Imw8rIy562OopWjb38w4smXge3YnVYwpgGJg/tLlRnTlQflwZgZ
         Id4F7RE8R2btNBqh/j1WSQS85gKDA971D2ul0s3NZ6oM4eDSVKM44/05cSgeTQmJtG
         YBLL9MXqMlsbLjiq6cNMqpy10mpIP1lNi28HQh769RAwZmy8nWz1RXZCsgnZJ+P8yb
         WdjpXDDej7ffqzyjjNQQSbXE=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E78740E01A1;
        Wed, 20 Sep 2023 13:23:48 +0000 (UTC)
Date:   Wed, 20 Sep 2023 15:23:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Huibin Shi <henrys@silicom-usa.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Henry Shi <henryshi2018@gmail.com>,
        "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: Re: [PATCH v7] platform/x86: Add Silicom Platform Driver
Message-ID: <20230920132343.GEZQryX/gCegY09+Qp@fat_crate.local>
References: <20230919211650.25325-1-henryshi2018@gmail.com>
 <69a6279d-a191-e294-3db2-8041c4208783@redhat.com>
 <PA4PR04MB9222B2266E6D146F4CF2EE8F9AF9A@PA4PR04MB9222.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9222B2266E6D146F4CF2EE8F9AF9A@PA4PR04MB9222.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:33:59AM +0000, Huibin Shi wrote:
> Sorry for missing your inline code comments. I will address them and
> send out new patch soon.

Don't send soon.

Take your time, give people a week to look at your patch and then send
a new version. Go over the replies so that you don't miss review
comments. Test it. Make sure you've designed it right. This is not
a contest about who sends a new revision as quickly as possible.

In the meantime, read this file:

From: Documentation/process/submitting-patches.rst

"Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
one week before resubmitting or pinging reviewers - possibly longer during
busy times like merge windows."

Thanks.

P.S. Do not top-post but put your reply text *under* the quoted text
you're replying to.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
