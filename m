Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7E375D624
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGUVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGUVHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:07:07 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B303E1FD2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:07:06 -0700 (PDT)
Message-ID: <16f50dff126af9b20f9b99ca056ad5fa.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1689973622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ars6Nadl+Rq72SQtLyiG6lEUopWtkDVGWzEjqH+jejY=;
        b=ADoRMfMcbu8+X2h3U7J4997/p9+vqLswDqPhf2a+PGTFdCtmbZc2Q8jqQVki+JagLpPHDe
        g8TqkMNKBy0UPHn50m1WhcDkSci00k/s2RAC7wLT1hnoc19PR+f0wPZfzFBQL0HrIHTkf2
        dO/as5liQpjWkf2vwnONWS791yTw6KHGQc8299Pb5w9h44RXihKeylXvE+lmJlXGaAYRRf
        WUl/GOKlmJUzyoiOUxyjQ0f0t+uQhtI+BoSQvYaYtKZ5n9wmEEmwzR7CVi/aQxPz/Tw7Gg
        EarBL0T2mTztxVY/7AG6nrK2BSZsnVLE3FcOk6F+w6hZtrTLfvNDGu6Zoqi8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1689973622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ars6Nadl+Rq72SQtLyiG6lEUopWtkDVGWzEjqH+jejY=;
        b=UGw1/OSnt32RLUbzsBlm6WHBa7mWkdwOAAuAGeJ0tgKfkLAvhzjvCEFOE5zuhtrB9WVp2k
        gEnZ+4DkP2825BWfbMTsZMSv5QZDJNvsWxGTsDIZke6hun1T+pMKoYSgP/LAuI9ro5UzH2
        n+JgpSKH/ppPVSlmsMMGUkBlsvuGRMvKjRL06x3l0ccs46MAazFXbulPL1oxx+HNVouVXI
        HCUAtnckK4s/Ovbr7tai97JhClAJFNYyiNoNk3sAuUo0BnWDGcqOsRwQimZzH+kq73Ee+O
        P9CyFDw02MoSC7A4nEkVSspJBzfqqrx0D4PWiv1JHHrmwLseWAtIre8WBBhrzQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1689973622; a=rsa-sha256;
        cv=none;
        b=aP3GaJpVhWlhKwR6OAA13BSZJskvHTtKei9fXcW3KOgBaA5SADqy74UYdQnA80rA+p3N3S
        2+UUDA6O6wEgnTWq4N6vkCGLdPnwnG+cO8AF9GIoUCm3lixxrVjT8pj52wcrVBMTFmv+/b
        lYJ+l7J/6GHQxBc89shCss95CY/ACfW3lpomxHWLYIkRWb7PefTMs5qhyDLqwdoNMX4MCb
        jDPtEinkHyA9mBt8k+PNKQHeQmgo8o5jwZh5usE6c67mlEp/KWTGUY2e3McOvR862Pk+he
        V46niyzRFBrQLwiZeZABh30+icHkb6oapAZclIPC0p0B8uMgzuwatLXxcP2nGQ==
From:   Paulo Alcantara <pc@manguebit.com>
To:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        Tom Talpey <tom@talpey.com>
Cc:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        Steve French <smfrench@gmail.com>, linkinjeon@kernel.org,
        shaggy@kernel.org, linux-cifs@vger.kernel.org,
        krisman@collabora.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dedupe smb unicode files
In-Reply-To: <ZLrxYzGXJzsLmGDs@gallifrey>
References: <20230628232417.120844-1-linux@treblig.org>
 <ZK80mu/YbHLEABAB@gallifrey>
 <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
 <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
 <ZLhchajZaWEVM6D7@gallifrey>
 <79bbb44c-f3b1-5c5c-1ad4-bcaab0069666@oracle.com>
 <d1f7fbe9-8fe2-e3e3-d6ff-1544204202ff@talpey.com>
 <ZLnJzUynpTBvZGtA@gallifrey>
 <f8f4a2c5-05d3-0b2d-688f-b3274a98fc73@talpey.com>
 <ZLrxYzGXJzsLmGDs@gallifrey>
Date:   Fri, 21 Jul 2023 18:06:57 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Dr. David Alan Gilbert" <linux@treblig.org> writes:

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl#n3737
> 	if ($realfile =~ /\.(h|s|S)$/) {
> 		$comment = '/*';
> 	} elsif ($realfile =~ /\.(c|rs|dts|dtsi)$/) {
> 		$comment = '//';
>
> I don't get where that idea came from.

Check Documentation/process/license-rules.rst.
