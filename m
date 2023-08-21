Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E17F782723
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjHUKdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjHUKd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:33:27 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 03:33:22 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080EFEE;
        Mon, 21 Aug 2023 03:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692613817; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I/y2wyBXuPwuR9GEf2qZhDEd4ek5aZ7u5b5dunlJD8l0W4B68b23AJr+YfexW3VWC1
    Lc8OzBBmiJp5LRaPs3EeHq5vktXda84ZIvSWTeCs5wMP8AogGC3kKg67AAWexQo3+MLk
    3u3vaGZRft3FTC+jNLe0n2bLF8G7Ie26Pv/Qh73hoBuTEr/2+Gvwbh24nyyk4VzwJmiF
    3r8HkXA+7O1XCWxflXfPCledQqbHHwFdvh83UDpffc+BUypMPYeFceQaLOpiYI4rv8WV
    grwJzPNVaN6e1xXuc3v16wrRocggB6aO3V/mvpXzjFeovlef1u7btTJ0b0ber1eQamU5
    g4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692613817;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eixnrX7klguE+rc8r2DrzRaeR5puIK4dbhqwJd4P+LA=;
    b=MDFVuf4b0apXK0GGan5EQKhyIRDTgvx+77igNpfrX3AbseSysVPtC/ejUDsf6EhWgX
    72htqB/vDdsjSDluG2e9xsgTxY7sxUrph+gC0SvICiEI77/UQu2Zuz3JHyf1jwmZrDcn
    cXRFveikyPCU3BwYq+ggxuqG+9xjRBaNXXCkCtROaiO1535KXU7s1lRczxSsm4PZqS1Y
    p/EPQfG5xSIofFewMsJzNJmyXoOf7iNIhShcZJ1S78o2T62dAs4G9ovrklmecP/eaPPW
    3ziOvclQldtZI2J5iWa/zMaMFo1O0t04+2JjXw6e/hiNyTZQQ28Qhk7+l4zyILn0Iofm
    YnwA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692613817;
    s=strato-dkim-0002; d=thson.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eixnrX7klguE+rc8r2DrzRaeR5puIK4dbhqwJd4P+LA=;
    b=P7BNu/SqPkV81Z0ZDmVrPqyVg8JoRGsmoYAfWC/gllI5xui+dbJZPBCy+WxH5452dA
    9HpSFz83/TNCMMOT0MSJJvN5unn8DIgGMKu2LpPMJzO3jAyGAt4HgrsPk+ZRl5QedPSJ
    QzgSfyN19FCAsNTcRTPAlxHrwAtNFf1iFrMzS/pZcFMtyxTmd4qjp+ka1xpVV3YAqO2a
    Gd4z8YwU3GRdGzua/m5lObwFgmKkDfsqervl+KEnN9SJCv9FwxNVXTwVCQ3lC2c6dfrR
    RJHfGbA/A3mmSEiwc5KWZNOBYDQT1koeNuQEcC4O8YYjkX27i9kR+Ry9YiLGbEHVJRin
    CLJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692613817;
    s=strato-dkim-0003; d=thson.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eixnrX7klguE+rc8r2DrzRaeR5puIK4dbhqwJd4P+LA=;
    b=B3iX/5oownP18H4gIgvtUZ4p84mTD0EB/goOCS38LNUS0p2RARNQBHIz1mJvpNoVO9
    HGCGy9Nqv3mWF7uA0iAA==
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7j/79t2yVxcUdnYNdU750Z8MLF6guL3bd"
Received: from [192.168.1.101]
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id tf602fz7LAUGFtu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 21 Aug 2023 12:30:16 +0200 (CEST)
Message-ID: <03cfdcc9-716f-4690-b400-c8da59ca1ef6@thson.de>
Date:   Mon, 21 Aug 2023 13:30:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] X.509: if signature is unsupported skip validation
To:     Jarkko Sakkinen <jarkko@kernel.org>, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230815112942.392572-1-public@thson.de>
 <CUU9O4ZKMDAV.20Q9VINXK6DI0@suppilovahvero>
Content-Language: en-US
From:   Thore Sommer <public@thson.de>
In-Reply-To: <CUU9O4ZKMDAV.20Q9VINXK6DI0@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.23 23:54, Jarkko Sakkinen wrote:
> On Tue Aug 15, 2023 at 2:29 PM EEST, Thore Sommer wrote:
>> When the hash algorithm for the signature is not available the digest size
>> is 0 and the signature in the certificate is marked as unsupported.
>>
>> When validating a self-signed certificate, this needs to be checked,
>> because otherwise trying to validate the signature will fail with an
>> warning:
>>
>> Loading compiled-in X.509 certificates
>> WARNING: CPU: 0 PID: 1 at crypto/rsa-pkcs1pad.c:537 \
>> pkcs1pad_verify+0x46/0x12c
>> ...
>> Problem loading in-kernel X.509 certificate (-22)
>>
>> Signed-off-by: Thore Sommer <public@thson.de>
>> ---
>>   crypto/asymmetric_keys/x509_public_key.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
>> index 6fdfc82e23a8..7c71db3ac23d 100644
>> --- a/crypto/asymmetric_keys/x509_public_key.c
>> +++ b/crypto/asymmetric_keys/x509_public_key.c
>> @@ -130,6 +130,11 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
>>   			goto out;
>>   	}
>>   
>> +	if (cert->unsupported_sig) {
>> +		ret = 0;
>> +		goto out;
>> +	}
>> +
>>   	ret = public_key_verify_signature(cert->pub, cert->sig);
>>   	if (ret < 0) {
>>   		if (ret == -ENOPKG) {
>> -- 
>> 2.41.0
> 
> Should have:
> 
> Cc: stable@vger.kernel.org # v4.7+
> Fixes: 6c2dc5ae4ab7 ("X.509: Extract signature digest and make self-signed cert checks earlier")
> 
> BR, Jarkko

Hi Jarkko,

should I resend it with the stable mailing list in CC or will it be 
added when a maintainer includes the change?

Best regards,
Thore
