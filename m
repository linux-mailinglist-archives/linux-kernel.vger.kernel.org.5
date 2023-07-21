Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0E75D430
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjGUTSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjGUTSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:18:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724D30ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1689967091; x=1690571891; i=ps.report@gmx.net;
 bh=1ZWvtawsdIcXHuIeyUmGHouCQYZmHgphhxCND5dxON0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=A1A9Sgf/67sI7BIdEASua7qHv6RHCiAZPAz2wZ3mpmXdGGVT8xwHy0N3VfuHYvVsEzKCNzH
 a6HB47sl9tu3qDQvrbPXePE3JmFnPSFkbW+0vkZH0tq5q4VFvFBZH0bOnOAEdfWxbqxh7UR28
 vvYDcgIJmYaimomNGqbYXuCT+dhoGA08NSot5kXOk6hGJ6BZ3WO83V2wp3mnYi9lcZ8sy210M
 mYbpgu2+bWxEE0Tv2PyjnMalOHae+NauNudPKdBuhNF25YCnBMd6KikFD/S6/IHTDB+H8Aohg
 hDbbS1mQxIbj3eTmFGjyavIOct3ymOps7ihbGIVsLDU7ao9Flg6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([62.216.209.39]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHMP-1pctRK1X8z-00kcpv; Fri, 21
 Jul 2023 21:18:11 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Simon Horman <simon.horman@corigine.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH v1] skbuff: remove unused HAVE_HW_TIME_STAMP feature define
Date:   Fri, 21 Jul 2023 21:18:05 +0200
Message-ID: <20230721191805.20411-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:eGZFDkVYcysSmP239F0u63dB8Ai+iCN8b5BEpTnI7s9qumTKR/S
 fX/D3PHYrp7oK1ihCaZjc+wT2j0ZQkmEhqtsNcBvHIs5OXlvkCqul7nzO6xfGeteyPSBtyz
 TDeSZ2QaNAmth7Q2VnsXJmzM7Aja04dfSy5v5dxquTC7rS9kK2XBhheCSTysj8u8iNLgkvO
 P43cHC2ygsBLKr7jE1Tog==
UI-OutboundReport: notjunk:1;M01:P0:OCwN7uUsrWU=;9mWY2k9FpslqoZrxqxQjW/utsB6
 CSxdge7N63fe3HylHSj9LZHdd40KxoNr86YXAmHU1E97t2JYKoBcP7+87Obypny9IqZr8DD/c
 I5w/hELFRGE0gy6JmElQiKEBkSt/4S6erEQLIY3svauFmAg3/hfUfpeUa83h/eVXpnJfIo2Zy
 WXX3FkKU/fLWb5uzgDsItJd7/0kGo4MZzujRiWicaT5zLpmGPpRCi+3vV7nhVQpu8vmdQ7OYe
 FzSZzqimNl9ZdYNfQkcsjP9JL1r0q4qKVVCSoTydbXK48Tjez4rQcWAgrXPTkSeC8mwrLU9OY
 AC6GW5aRrtq1g/Mj+T6e96ttS0o6At7C+7+RcSvS/GFh4tDxzOTfL3fUM+bXqHl6laDZd1LJM
 PvuUonM/pEcMLpE+v1ob9YEY3zf9XgIsOe+t6ffWOE5nKpikbto4WESFfyytbVFdxhRBRNu5d
 MMmbe6XZbtw5GyewpyRDjMZ30usFXHI1bcFiIvahyn04WiilSuTrkcOPD/zABN0QIb92Z3J07
 rd0+dGQ1oh03gX4mO36u1G5vatXdwGM73F8idJvbpYOiWbuxOSmoaIcsTXw5IBPxCv2r6S63L
 QfcIqZg1lGfljpaXSb21+Wyy9jyHQrVdj/EpCDQiIDTZeUafBXtyHIK60q+LXGIRHcAaKlPtd
 l1/DQSq1hOFIdBmOwySMsl1BMT/QN0Yrd8NJJsPrX1rFyVGYO3sdT8tTIwEKPtnxgTh8TYAXI
 65Xst4a/A5hcZ93FCaOVa4ZzhqaTGPHzD/Ln014frTQc5EDEWcUjOwdr4heRIrHB6L0Ve5IaC
 aHNGQIqs0s31PDG8mYgk0PRX3Qz11HdWY6N3dBp2BudqeJyaLCU713Uv3c2FfKbMvVZYI8UWf
 +X1Rfqk+4KhMNjWfOdGnwNWpFIntjccAHuFfVYb7reHXiBlsCzUiPUvY/o2GI78jBq9JnUvRX
 W/88OpIpA9Ki7s5/us7TKvlFXDw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVtb3ZlIHVudXNlZCBIQVZFX0hXX1RJTUVfU1RBTVAgZmVhdHVyZSBkZWZpbmUgKGludHJvZHVj
ZWQgYnkKY29tbWl0IGFjNDVmNjAyZWUzZCAoIm5ldDogaW5mcmFzdHJ1Y3R1cmUgZm9yIGhhcmR3
YXJlIHRpbWUgc3RhbXBpbmciKS4KClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5y
ZXBvcnRAZ214Lm5ldD4KLS0tCiBpbmNsdWRlL2xpbnV4L3NrYnVmZi5oIHwgMiAtLQogMSBmaWxl
IGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9za2J1
ZmYuaCBiL2luY2x1ZGUvbGludXgvc2tidWZmLmgKaW5kZXggZmFhYmEwNTBmODQzLi4xNmE0OWJh
NTM0ZTQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2tidWZmLmgKKysrIGIvaW5jbHVkZS9s
aW51eC9za2J1ZmYuaApAQCAtNDQxLDggKzQ0MSw2IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBza2Jf
ZnJhZ19tdXN0X2xvb3Aoc3RydWN0IHBhZ2UgKnApCiAJICAgICBjb3BpZWQgKz0gcF9sZW4sIHAr
KywgcF9vZmYgPSAwLAkJCQlcCiAJICAgICBwX2xlbiA9IG1pbl90KHUzMiwgZl9sZW4gLSBjb3Bp
ZWQsIFBBR0VfU0laRSkpCQlcCiAKLSNkZWZpbmUgSEFWRV9IV19USU1FX1NUQU1QCi0KIC8qKgog
ICogc3RydWN0IHNrYl9zaGFyZWRfaHd0c3RhbXBzIC0gaGFyZHdhcmUgdGltZSBzdGFtcHMKICAq
IEBod3RzdGFtcDoJCWhhcmR3YXJlIHRpbWUgc3RhbXAgdHJhbnNmb3JtZWQgaW50byBkdXJhdGlv
bgotLSAKMi40MS4wCgo=
