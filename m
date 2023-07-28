Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1793376671E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjG1I2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjG1I1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:27:22 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFD5230EA;
        Fri, 28 Jul 2023 01:27:18 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
        by gateway (Coremail) with SMTP id _____8Cx7+vke8Nk4T8LAA--.26916S3;
        Fri, 28 Jul 2023 16:27:16 +0800 (CST)
Received: from chenhuacai$loongson.cn ( [112.20.109.108] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 28 Jul 2023 16:27:13
 +0800 (GMT+08:00)
X-Originating-IP: [112.20.109.108]
Date:   Fri, 28 Jul 2023 16:27:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To:     loongson-kernel@lists.loongnix.cn
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jianmin Lv" <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        "Liu Peibao" <liupeibao@loongson.cn>,
        "Yinbo Zhu" <zhuyinbo@loongson.cn>, "Liu Yun" <liuyun@loongson.cn>
Subject: Re: [PATCH v5 0/2] soc: loongson2_pm: add power management support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT5 build
 20230523(b0518e05) Copyright (c) 2002-2023 www.mailtech.cn .loongson.cn
In-Reply-To: <20230728074944.26746-1-zhuyinbo@loongson.cn>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: VsEg+mZvb3Rlcl90eHQ9MzMzNjo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <74a37e9d.9a24.1899b9bea85.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8AxOM3ie8NkkRE+AA--.6210W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQAGBmTDQC8ECQAAsE
X-Coremail-Antispam: 1Uk129KBj93XoWxZF1kWr4DGw1DWrWUAF1rXwc_yoW5uw4Dpa
        nxCrs8Cr4UJr18ZwsxGrWUC3W5Z395Gr9rXrsxGa43u3srZ345ZF1IkF15ZrsFyry5ta17
        XFykGr4kKa1UGFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUQSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwCY1x0262kKe7AK
        xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267
        AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr1l6VACY4
        xI67k04243AbIYCTnIWIevJa73UjIFyTuYvjxU4rgADUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZC1ieTogSHVhY2FpIENoZW4gPGNoZW5odWFjYWlAbG9vbmdzb24uY24+CgoKPiAtLS0t
LeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiWWluYm8gWmh1IiA8emh1eWluYm9AbG9v
bmdzb24uY24+Cj4g5Y+R6YCB5pe26Ze0OjIwMjMtMDctMjggMTU6NDk6NDIgKOaYn+acn+S6lCkK
PiDmlLbku7bkuro6ICJBcm5kIEJlcmdtYW5uIiA8YXJuZEBhcm5kYi5kZT4sICJSb2IgSGVycmlu
ZyIgPHJvYmgrZHRAa2VybmVsLm9yZz4sICJLcnp5c3p0b2YgS296bG93c2tpIiA8a3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnPiwgIkNvbm9yIERvb2xleSIgPGNvbm9yK2R0QGtlcm5l
bC5vcmc+LCBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcsIGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4g5oqE6YCBOiAiSmlhbm1pbiBMdiIg
PGx2amlhbm1pbkBsb29uZ3Nvbi5jbj4sIHdhbmdob25nbGlhbmdAbG9vbmdzb24uY24sICJMaXUg
UGVpYmFvIiA8bGl1cGVpYmFvQGxvb25nc29uLmNuPiwgbG9vbmdzb24ta2VybmVsQGxpc3RzLmxv
b25nbml4LmNuLCAiWWluYm8gWmh1IiA8emh1eWluYm9AbG9vbmdzb24uY24+LCAiTGl1IFl1biIg
PGxpdXl1bkBsb29uZ3Nvbi5jbj4KPiDkuLvpopg6IFtQQVRDSCB2NSAwLzJdIHNvYzogbG9vbmdz
b24yX3BtOiBhZGQgcG93ZXIgbWFuYWdlbWVudCBzdXBwb3J0Cj4gCj4gTG9vbmdzb24tMiBwbGF0
Zm9ybSBzdXBwb3J0IFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbGxlciAoQUNQSSkgYW5kIHRoaXMK
PiBzZXJpZXMgcGF0Y2ggd2FzIHRvIGFkZCBQTSBkcml2ZXIgdGhhdCBiYXNlIG9uIGR0cyBhbmQg
UE0gYmluZGluZyBzdXBwb3J0Lgo+IAo+IENoYW5nZSBpbiB2NToKPiAJCTEuIFRoZSBwYXRjaCAi
W1BBVENIIHYzIDEvM10gbG9vbmdhcmNoOiBleHBvcnQgc29tZSBhcmNoLXNwZWNpZmljCj4gCQkg
ICBwbSBpbnRlcmZhY2VzIiBoYWQgYmVlbiBtZXJnZWQgaW50byBsaW51eC1uZXh0IHRyZWUgdGh1
cyB0aGlzCj4gCQkgICB2NCBzZXJpZXMgcGF0Y2ggbmVlZCBkcm9wIGl0IGFuZCBuZWVkIGRlcGVu
ZCBvbiBpdCBhbmQgaXQncwo+IAkJICAgcGF0Y2ggbGluayB3YXM6Cj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjMwNjE1MDkxNzU3LjI0Njg2LTItemh1eWluYm9AbG9vbmdzb24uY24v
Cj4gCQkyLiBTd2FwIHRoZSBwb3NpdGlvbnMgb2YgY29tcGF0aWJsZSBmb3IgMmsxMDAwIGFuZCAy
azA1MDAuCj4gQ2hhbmdlIGluIHY0Ogo+IAkJMS4gVGhlIHBhdGNoICJbUEFUQ0ggdjMgMS8zXSBs
b29uZ2FyY2g6IGV4cG9ydCBzb21lIGFyY2gtc3BlY2lmaWMKPiAJCSAgIHBtIGludGVyZmFjZXMi
IGhhZCBiZWVuIG1lcmdlZCBpbnRvIGxpbnV4LW5leHQgdHJlZSB0aHVzIHRoaXMKPiAJCSAgIHY0
IHNlcmllcyBwYXRjaCBuZWVkIGRyb3AgaXQgYW5kIG5lZWQgZGVwZW5kIG9uIGl0IGFuZCBpdCdz
Cj4gCQkgICBwYXRjaCBsaW5rIHdhczoKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MzA2MTUwOTE3NTcuMjQ2ODYtMi16aHV5aW5ib0Bsb29uZ3Nvbi5jbi8KPiAJCTIuIFJlbW92ZSB0
aGUgcG1jIGxhYmVsIGluIGR0LWJpbmRpbmcgcGF0Y2guCj4gCQkzLiBBZGQgdGhlIENvLWRldmVs
b3BlZC1ieSBmb3IgZHJpdmVyIHBhdGNoLgo+IAkJNC4gU2ltcGxpZnkgdGhlIGxvb25nc29uMl9z
dXNwZW5kX3ZhbGlkX3N0YXRlIHRoYXQgInJldHVybgo+IAkJICAgKHN0YXRlID09IFBNX1NVU1BF
TkRfTUVNKSIuCj4gCQk1LiBVc2UgVXNpbmcgbG9vbmdzb24yX3BtX2lycV9lbmFibGUoKSB0byBy
ZXBsYWNlLgo+IAkJICAgbG9vbmdzb24yX3Bvd2VyX2J1dHRvbl9pcnFfZW5hYmxlKCkuCj4gCQk2
LiBSZW1vdmUgdGhlICJvbmVPZiIgaW4gZHQtYmluZGluZ3MgcGF0Y2guCj4gCQk3LiBSZXBsYWNl
ICJzdXNwZW5kLWFkZHJlc3MiIHRoYXQgdXNlICJsb29uZ3NvbixzdXNwZW5kLWFkZHJlc3MiLgo+
IAkJOC4gVXNlIHU2NCB0eXBlIHRoYXQgZm9yICJsb29uZ3NvbixzdXNwZW5kLWFkZHJlc3MiLgo+
IAkJOS4gUmVuYW1lICJwbSIgdG8gInBvd2VyLW1hbmdlbWVudCIgaW4gZHQtYmluZGluZ3MgcGF0
Y2guCj4gCQkxMC4gQWRkIHRoZSByZWl2ZXdlZC1ieSBmb3IgZHQtYmluZGluZ3MgcGF0Y2guCj4g
Q2hhbmdlIGluIHYzOgo+IAkJMS4gUmV3b3JkIHRoZSBbMS8zXSBwYXRjaCBjb21taXQgbG9nIGFu
ZCB0aXRsZS4KPiAJCTIuIFVzZSB0aGUgb2xkIG5hbWluZyBmb3Igc3VzcGVuZCBpbnRlcmZhY2Ug
Zm9yIHRoZSBbMS8zXSBhbmQKPiAJCSAgIFszLzNdIHBhdGNoLgo+IAkJMy4gQ29tYmluZSBzb21l
IHNtYWxsIGZ1bmN0aW9uIGluIHRoZSBkcml2ZXIgcGF0Y2guCj4gCQk0LiBSZW5hbWUgJ3B3cmJ0
JyB0byAnYnV0dG9uJyBpbiB0aGUgZHJpdmVyIHBhdGNoLgo+IAkJNS4gVXNlIHRoZSBzcGVjaWZp
YyBjb21wYXRpYmxlIGluIHlhbWwgZmlsZS4KPiBDaGFuZ2UgaW4gdjI6Cj4gCQkxLiBGaXh1cCB0
aGUgInN1c3BlbmQtYWRkcmVzcyIgZGVzY3JpcHRpb24uCj4gCQkyLiBSZW1vdmUgdGhlICJyZXR1
cm4gLUVJTlZBTCIgaW4gUE0gZHJpdmVyIHByb2JlIHdoZW4gZmlybXdhcmUKPiAJCSAgIG5vIGNv
bmZpZ3VyZSAic3VzcGVuZC1hZGRyZXNzIiBwcm9wZXJ0eSBpbiBkdHMgaW4gb2RlciB0bwo+IAkJ
ICAgb3RoZXIgUE0gc3RhdGUgdG8gd29yay4KPiAKPiBZaW5ibyBaaHUgKDIpOgo+ICAgc29jOiBk
dC1iaW5kaW5nczogYWRkIGxvb25nc29uLTIgcG0KPiAgIHNvYzogbG9vbmdzb24yX3BtOiBhZGQg
cG93ZXIgbWFuYWdlbWVudCBzdXBwb3J0Cj4gCj4gIC4uLi9zb2MvbG9vbmdzb24vbG9vbmdzb24s
bHMyay1wbWMueWFtbCAgICAgICB8ICA1MiArKysrKwo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKwo+ICBkcml2ZXJzL3NvYy9sb29uZ3Nvbi9L
Y29uZmlnICAgICAgICAgICAgICAgICAgfCAgMTAgKwo+ICBkcml2ZXJzL3NvYy9sb29uZ3Nvbi9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ICBkcml2ZXJzL3NvYy9sb29uZ3Nvbi9s
b29uZ3NvbjJfcG0uYyAgICAgICAgICAgfCAyMTUgKysrKysrKysrKysrKysrKysrCj4gIDUgZmls
ZXMgY2hhbmdlZCwgMjg1IGluc2VydGlvbnMoKykKPiAKPiAtLSAKPiAyLjIwLjEKPiAKPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExvb25nc29uLWtl
cm5lbCBtYWlsaW5nIGxpc3QgLS0gbG9vbmdzb24ta2VybmVsQGxpc3RzLmxvb25nbml4LmNuCj4g
VG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsb29uZ3Nvbi1rZXJuZWwtbGVhdmVAbGlz
dHMubG9vbmduaXguY24KDQoNCuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+aciem+meiKr+S4reen
keeahOWVhuS4muenmOWvhuS/oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4
reWIl+WHuueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9
leW9ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWcsOazhOmc
suOAgeWkjeWItuaIluaVo+WPke+8ieacrOmCruS7tuWPiuWFtumZhOS7tuS4reeahOS/oeaBr+OA
guWmguaenOaCqOmUmeaUtuacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumA
muefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7tuOAgiANClRoaXMgZW1haWwgYW5kIGl0cyBh
dHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIExvb25nc29u
IFRlY2hub2xvZ3kgLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVu
dGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3Jt
YXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGlt
aXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24gb3IgZGlz
c2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQo
cykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxl
YXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBk
ZWxldGUgaXQuIA==

