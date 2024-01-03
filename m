Return-Path: <linux-kernel+bounces-15151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903D18227CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E241F23972
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B745F15EBB;
	Wed,  3 Jan 2024 04:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="WgD2xfad"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17256171C8;
	Wed,  3 Jan 2024 04:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:Message-ID:Date:MIME-Version:
	User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	Content-Type:Content-Transfer-Encoding; bh=RdP5G/aKqC3DA/6PNLSsJ
	nO0Jjn+tIXQ9bo4/leXkR8=; b=WgD2xfadUERoZXgKrw7Dz5s5PAc9XgiqkX68J
	UvwsJ1JtAhB8zPpOoqdYtayJMczf2bI5TYRJC+yJn1j6geQ3Jef05qxi6yRaIlSs
	i8nE2ZuejHuIUr5XD1fnzl2A+zWC2ZC9DV1ChaNzWmOIPH72+A1mq1eKovyiZD/c
	gfrKh4=
Received: from [192.168.1.113] (unknown [10.130.147.18])
	by coremail-app1 (Coremail) with SMTP id OCz+CgAHOFq+4JRl7KGiAA--.48397S2;
	Wed, 03 Jan 2024 12:21:19 +0800 (CST)
Message-ID: <5bf5738d-81d7-4bef-8f55-2a4a85b72c86@buaa.edu.cn>
Date: Wed, 3 Jan 2024 12:21:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] Bluetooth: rfcomm: Fix null-ptr-deref in
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, sy2239101@buaa.edu.cn
References: <CABBYNZJoH9WZ8cadJG9H63T5FvG0KS0uSNKrZFP4XvOPWy+APw@mail.gmail.com>
From: Yuxuan-Hu <20373622@buaa.edu.cn>
In-Reply-To: <CABBYNZJoH9WZ8cadJG9H63T5FvG0KS0uSNKrZFP4XvOPWy+APw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:OCz+CgAHOFq+4JRl7KGiAA--.48397S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4UWr47AFW7uF15AF48Xrb_yoWrJFyfpr
	Z0k3WSkF93Jr15Ar97Aa18uFyrZw1v9F15Gws5ZrW5C3s5W34xtryIkr1Uua4Uurs0k3yx
	ZF4UXFZrGr9rurJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
	xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAI
	w28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Aw1UJr1UMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: ysqtljawssquxxddhvlgxou0/

Hi Luiz,

I apologize for sending too many emails and causing any inconvenience. 
However, I forgot to add the CC List in the previous email, and there 
was something wrong with the version change description in the 
previously submitted V2 patch. Therefore, I have now submitted the patch 
again. I sincerely apologize for any inconvenience caused.

I have attempted to fix this bug using the method you described in your 
response. After our testing, we have confirmed that this method is 
effective, and now the KASAN will not be triggered. I have submitted a 
new version of the patch.

https://patchwork.kernel.org/project/bluetooth/patch/20240103040611.3279681-1-20373622@buaa.edu.cn/

Thank you once again, and I sincerely look forward to your response.

On 2024/1/3 1:02, Luiz Augusto von Dentz wrote:
> Hi Yuxuan,
>
> On Tue, Dec 26, 2023 at 2:40 AM Yuxuan Hu <20373622@buaa.edu.cn> wrote:
>> During our fuzz testing of the connection and disconnection process at the
>> RFCOMM layer,we discovered this bug.By comparing the packetsfrom a normal
>> connection and disconnection process with the testcase that triggered a
>> KASAN report, we analyzed the cause of this bug as follows:
>>
>> 1. In the packets captured during a normal connection, the host sends a
>> `Read Encryption Key Size` type of `HCI_CMD` packet(Command Opcode: 0x1408)
>> to the controller to inquire the length of encryption key.After receiving
>> this packet, the controller immediately replies with a Command Complete
>> packet (Event Code: 0x0e) to return the Encryption Key Size.
>>
>> 2. In our fuzz test case, the timing of the controller's response to this
>> packet was delayed to an unexpected point: after the RFCOMM and L2CAP
>> layers had disconnected but before the HCI layer had disconnected.
>>
>> 3. After receiving the Encryption Key Size Response at the time described
>> in point 2, the host still called the rfcomm_check_security function.
>> However, by this time `struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;`
>> had already been released, and when the function executed
>> `return hci_conn_security(conn->hcon, d->sec_level, auth_type, d->out);`,
>> specifically when accessing `conn->hcon`, a null-ptr-deref error occurred.
>>
>> Adding a check for whether `conn` is a null pointer to fix this bug.
>>
>> Signed-off-by: Yuxuan Hu <20373622@buaa.edu.cn>
>> ---
>>   net/bluetooth/rfcomm/core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
>> index 053ef8f25fae..5ffa197fdb48 100644
>> --- a/net/bluetooth/rfcomm/core.c
>> +++ b/net/bluetooth/rfcomm/core.c
>> @@ -228,6 +228,9 @@ static int rfcomm_check_security(struct rfcomm_dlc *d)
>>                  auth_type = HCI_AT_NO_BONDING;
>>                  break;
>>          }
>> +
>> +       if (!conn)
>> +               return 0;
> This shall probably be handled earlier, perhaps on rfcomm_process_rx
> if we can check that had been disconnected, that way we drop packets
> that we know don't have any effect since later we do call
> rfcomm_session_close e.g:
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 053ef8f25fae..1d34d8497033 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1941,7 +1941,7 @@ static struct rfcomm_session
> *rfcomm_process_rx(struct rfcomm_session *s)
>          /* Get data directly from socket receive queue without copying it. */
>          while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
>                  skb_orphan(skb);
> -               if (!skb_linearize(skb)) {
> +               if (!skb_linearize(skb) && sk->sk_state != BT_CLOSED) {
>                          s = rfcomm_recv_frame(s, skb);
>                          if (!s)
>                                  break;
>


