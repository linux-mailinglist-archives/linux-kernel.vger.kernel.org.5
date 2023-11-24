Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CCA7F7EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjKXSej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjKXSei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:34:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7872319AA;
        Fri, 24 Nov 2023 10:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700850882; x=1701455682; i=rwarsow@gmx.de;
        bh=Z0sKSE9k2MBhD/p3zzvyLHNgYVL/IX9EG0njTrSSTAI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=pwHPTH6FgjUAm58943zV1byWWHxDa9IuZzDakysd4YeuI2YK3AafNHTpoGCfdJ1n
         jkC/XPlVMCayXAsofq3tWY5ekZNL8MT+UMb0wZPiMZJxQ3RDN7e9IgpBX91Yn6VtI
         e5j8nk+I41rhnSOvx+bCeql15fRS8urKVm9h48GXKndqXOLRvxmpeQHMPlFwgkIvy
         YxIzSrUgjRk6MHs+jqOSe29bWQEnQ18wggX/qAKeNenV1DuD68EvPbGHfPQ2iCRgD
         dvg+5C7IzwzjsbIdGRSDerTgjZPgKSZcvPDmykFlJ00H3xYeXHObAQLfTVWva1f/g
         azsbXqnEO3H8tWPozw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([87.122.80.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSt8W-1qjvw41ADe-00UGYd; Fri, 24
 Nov 2023 19:34:42 +0100
Message-ID: <3d842616-34f1-4e75-977c-eb09bb70862d@gmx.de>
Date:   Fri, 24 Nov 2023 19:34:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 000/530] 6.6.3-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:46C3qdJzyJxs5Ui5SHdIS1SqcikRIjiMyfznfiq/dx+f6x0rbnM
 AHwx1IHPAg4dbshKzFl7vBe8cETkaPFmYa0OuAyw1ogzSJhyrlDGyR56NBT3dgWV0yIOYY7
 n/gYuUWnVvnFp369JTSKjuiIqkd4JqKSSW3ewGv/+51VfwTHnJvu0VllDs8rt8SXpFdnris
 +Tuq9933qdH3lMVNkMVtg==
UI-OutboundReport: notjunk:1;M01:P0:8MRSnYosezI=;Z4N3UdgwMeEzhQWhgRZ5ut/tlWT
 HkTvezners/i9FSpVUdsdMR2APuiY/mt3yjOqnUoVCjuYMD0KnTNRq7E8KnDT6MG52FVZRAvr
 JNDb6LgNCDY5dpC4nEpMNXJKblctOGToo+2OG5YOPaiPtuNKv8XJ8U6PNHFj6DWEWo0ypye2R
 2LHo66ojaPivyVtTaSdt9xfm9cy2WzrHmhoCjTap9WsMmElkcaXbXS81f1ZQjKhpdXFXGbL6P
 t8i+t+kZOlZwlsCScZAVJKEcxYGgQ4CNoD1FPf1rg4NsD65m7Jb6ET5mmNyhW3fxyH0KCW+td
 HjW3nWUuD7GT0kOM7hSBQ6TXea+RkMmkfZZXG+wn3tLalwFF7y+yUDlqsoXbqUfySM9yuuYTV
 MUrs22g5KOnPUbogyC7+Jt2lkMGCA5ZdVMDD2FJEILs08P/zFVH5WKggUiQgMR0eOtk3QgsP+
 5X/T0ZAb7Fwy+Yh5oM7deMK0qngmDVsKhr5pE/TkOkCmnsCfEeRDTTqOPsn0+jJ+ujAK+cMh9
 QwLeYVysBYS3kuZaN+3+D8vwm5XsiSAyNMLNeoeTMdOQBSpqzAQB2h3pHbYzfL3r1JjKJetrR
 r4KNE62toge2fNlFMKMtI/iuhxK7i9sdH5YUg0gahZl8w1ovaf9clGaFMnSxrwKE5wI0g0u6Q
 KT5u2UpYc+a8C39shu44pTpAyAUsOnU87wh2e1u6hUtkGLFvH3oREaKZ/6NQylSsrAewYJZ3k
 m9vuX35ki5d/a0dwLlU36HfwOu4RWX56+9ZzagJw6/l4Z6Wmk9tCn+jZU/Ikt1tNvns66nd9C
 oSI+SDJsvulbWGi57ipGA/sH5n6nhlqnCME/67Ueg10xAWF+6BQn+1Jknf1YsMGpaEkvUe/sD
 N4g5HOdrEKuGZOtCVBrGWwuji9d3sWopiF0EwD1ilIrlPxBcjLrhgJTWUv+15YeNStsnOdhWK
 DiucKA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.6.3-rc1

compiles, boots and runs[1] here on x86_64
(Intel Rocket Lake: i5-11400)

Thanks

[1] a vbox crash I first got known off today:
https://www.virtualbox.org/ticket/21898


Tested-by: Ronald Warsow <rwarsow@gmx.de>

