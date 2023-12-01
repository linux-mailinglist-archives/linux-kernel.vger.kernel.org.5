Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02AF80017B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjLACQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376685AbjLACQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:16:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAD113E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:16:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso1789703a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1701396986; x=1702001786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn0QnCH5LO1wxkqslDRODFYiyp1N855c1+cQJG9OMX4=;
        b=Blu4eoS9116T3hsjHgAAzasW6RZCCmMFGVK8OZ/X8mMP3rUutGqQI0PnPnZGRUDHO6
         PYI95MRMa5R2LmZ8nUll2qlrt5+IB2sSdty8+Lv7EjAAPNlESqMMS+PJExbzVadyH+r1
         cei4IbY4w8iVg9YQxJQq1bKqAgiv12wma80epcU24MF7kDIHWWYuZ4LxnW8GWKhh1RNJ
         gdaIEXlGU6xxA9Mbb6N7BRXbPr5WvuTycMfkbuwP1BKfKfd/5hTzjpqz1sCbvypzHjOT
         yvXpJOBLTG5ANCBY5yq5hpXdn8dFb8etnt4hkaLPUQLtqI1hg+u2JENhpLYwVW4XHGdE
         WTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701396986; x=1702001786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn0QnCH5LO1wxkqslDRODFYiyp1N855c1+cQJG9OMX4=;
        b=LDMKJLDX9T4iUdaod8iAIYATlc5237ZBCgB0mYwkyUOG8EkavCnYdDP/YUIoQI/0mv
         y9roCTM1ESVhVa0biFizF7DZdc9+R0v3QdmS2rydOeZN990mAXZT92IN1drcpuyNasCD
         iiZiZ/kEGQaAwPkjCSLTOA5l1njvQm57FvQnmPyn4dcofQjSfs4QBuS1gHsQHXXyTAQS
         /2GgFW4hV961PNV7DeX5LB0/Vwi7QE0Tt+udsVkqzPiewYMDd1CjYcbW7HjiMkEScpM7
         AZKKcdDNaSqLBOh8xxLW+t8KASqIXzd6E7WdQxZLuX7O7emBKmOpxTysSn7x+v+5jkx9
         CQ3A==
X-Gm-Message-State: AOJu0YyH7dM67/ywfrydNJMp0XbQtiHHit8pi6mXRcUgnX+FQCbNKx8S
        sCsZUoFU3dQVefbX9QvtcSLFHIsOBlSGPAPPLUrzlrtj8yamZibbORx69Q==
X-Google-Smtp-Source: AGHT+IFzfa64mU60Ky4221Aav521Jw7+/tEfK4bvh1LJTHMamYXWL+PSMTKnbKqLNJ5DkBisXbjazbDSmPoA4JGPEfI=
X-Received: by 2002:a50:8ac8:0:b0:54c:4837:93e9 with SMTP id
 k8-20020a508ac8000000b0054c483793e9mr310690edk.48.1701396986227; Thu, 30 Nov
 2023 18:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20231127143238.1216582-1-vincent.guittot@linaro.org>
 <20231127143238.1216582-2-vincent.guittot@linaro.org> <8009d5c4-4012-44a2-883c-0d7f74c4a2c1@arm.com>
In-Reply-To: <8009d5c4-4012-44a2-883c-0d7f74c4a2c1@arm.com>
From:   Tang Yizhou <yizhou.tang@shopee.com>
Date:   Fri, 1 Dec 2023 10:16:15 +0800
Message-ID: <CACuPKxm8GJ6L5wYqejHttz1E26wg751ZDWi7ry+KVBe+fEDVeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, lukasz.luba@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBEZWMgMSwgMjAyMyBhdCA0OjMw4oCvQU0gSG9uZ3lhbiBYaWEgPGhvbmd5YW4ueGlh
MkBhcm0uY29tPiB3cm90ZToNCj4NCj4gSGVyZSBpdCBpcyBpbiBjYXNlIHlvdSBoYXZlIHRvIHBy
b3ZpZGUgdGhlIHRyYW5zbGF0aW9uOg0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90
cmFuc2xhdGlvbnMvemhfQ04vc2NoZWR1bGVyL3NjaGVkdXRpbC5yc3QNCj4gYi9Eb2N1bWVudGF0
aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9zY2hlZHVsZXIvc2NoZWR1dGlsLnJzdA0KPiBpbmRleCBk
MWVhNjgwMDc1MjAuLjdjOGQ4N2YyMWM0MiAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90
cmFuc2xhdGlvbnMvemhfQ04vc2NoZWR1bGVyL3NjaGVkdXRpbC5yc3QNCj4gKysrIGIvRG9jdW1l
bnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vc2NoZWR1bGVyL3NjaGVkdXRpbC5yc3QNCj4gQEAg
LTg5LDE2ICs4OSwxNSBAQA0KPiByX2Nwdeiiq+WumuS5ieS4uuW9k+WJjUNQVeeahOacgOmrmOaA
p+iDveawtOW5s+S4juezu+e7n+S4reS7u+S9leWFtuWug0NQVeeahOacgA0KPiAgICAtIERvY3Vt
ZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3NjaGVkdWxlci9zY2hlZC1jYXBhY2l0eS5yc3Q6
IjEuDQo+IENQVSBDYXBhY2l0eSArIDIuIFRhc2sgdXRpbGl6YXRpb24iDQo+DQo+DQo+IC1VVElM
X0VTVCAvIFVUSUxfRVNUX0ZBU1RVUA0KPiAtPT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4g
K1VUSUxfRVNUDQo+ICs9PT09PT09PQ0KPg0KPg0KPiDnlLHkuo7lkajmnJ/mgKfku7vliqHnmoTl
ubPlnYfmlbDlnKjnnaHnnKDml7bkvJroobDlh4/vvIzogIzlnKjov5DooYzml7blhbbpooTmnJ/l
iKnnlKjnjofkvJrlkoznnaHnnKDliY3nm7jlkIzvvIwNCj4gICDlm6DmraTlroPku6zlnKjlho3m
rKHov5DooYzlkI7kvJrpnaLkuLTvvIhEVkZT77yJ55qE5LiK5rao44CCDQo+DQo+ICAg5Li65LqG
57yT6Kej6L+Z5Liq6Zeu6aKY77yM77yI5LiA5Liq6buY6K6k5L2/6IO955qE57yW6K+R6YCJ6aG5
77yJVVRJTF9FU1TpqbHliqjkuIDkuKrml6DpmZDohInlhrLlk43lupQNCj4gICDvvIhJbmZpbml0
ZSBJbXB1bHNlIFJlc3BvbnNl77yMSUlS77yJ55qERVdNQe+8jOKAnOi/kOihjOKAneWAvOWcqOWH
uumYn+aXtuaYr+acgOmrmOeahOOAgg0KPiAt5Y+m5LiA5Liq6buY6K6k5L2/6IO955qE57yW6K+R
6YCJ6aG5VVRJTF9FU1RfRkFTVFVQ5L+u5pS55LqGSUlS5ruk5rOi5Zmo77yM5L2/5YW25YWB6K64
56uL5Y2z5aKe5Yqg77yMDQo+IC3ku4XlnKjliKnnlKjnjofkuIvpmY3ml7boobDlh4/jgIINCj4g
K1VUSUxfRVNU5ruk5rOi5L2/5YW25Zyo6YGH5Yiw5pu06auY5YC85pe256uL5Yi75aKe5Yqg77yM
6ICM6YGH5Yiw5L2O5YC85pe25Lya57yT5oWi6KGw5YeP44CCDQo+DQoNCkhpIEhvbmd5YW4sDQoN
ClRoYW5rcyBmb3IgeW91ciBDaGluZXNlIGRvY3VtZW50YXRpb24gdHJhbnNsYXRpb24hDQoNCkZv
ciB0aGUgdHJhbnNsYXRpb246DQpSZXZpZXdlZC1ieTogVGFuZyBZaXpob3UgPHlpemhvdS50YW5n
QHNob3BlZS5jb20+DQoNClRoYW5rcywNCllpemhvdQ0K
