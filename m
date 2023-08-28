Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D5078B138
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjH1M70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjH1M7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:59:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A1011C;
        Mon, 28 Aug 2023 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693227552; x=1693832352; i=rwarsow@gmx.de;
 bh=Sp9xJK9z8qxahavi8wfZaCf1HV2tA2qjs6U3xm/TnoU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=ufCyneihF5w7wv7v1KUeuEoromoeer1SdhTyf9m+o9zTAcVs6hysEgHHBEi/MNRPa9M4bMP
 5R1LDRgTkaMPaDvead4SftJyWve+x8Emlm04OBwtUHGB7Jejfm+LHPvG9h5wKUM1Bv+2HspaY
 lEY4au3ApqcWUDDlLWsT3znRS+JmYS3kcn3w6wntXKEuZnz10JyPJnE++ZfpWUOlzjfe1hHBd
 t+sPGLn6QdcT1hqfa7JMWzUUlJ3kLTQfNtuPNzz1WhD8MWpraHBDTUEAa0PYmLcpkZrK82z+t
 45LxHyrsFaxzHZyFTpj5N1HJXVTKbKMLvMWsfbCqZ16EiEapiNgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.180]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4QsY-1paQpK2ft0-011RG9; Mon, 28
 Aug 2023 14:59:12 +0200
Message-ID: <0cf15e33-9972-f63c-8602-70c8f6971c11@gmx.de>
Date:   Mon, 28 Aug 2023 14:59:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eVVWlXTPD4GB1OJmNl5gNhwVZ0zqa7dhl5lj55RFy/9ePbtbCks
 8/bHG7pVCaPxrsDd02vzj22KO3QYJZYUBZDxqLLkfxgcpdTKBqiv6QurQ+0clp9PitI4KCh
 eRqwsJHx0OqgvnKfu+R3EwY3VoeUe4tqrY/9zhU8KB4kVW9aQOAsQIe3hBrAlsJ791eE3MV
 TamnzRe82YYNW4JE9udLA==
UI-OutboundReport: notjunk:1;M01:P0:6hbeup7vLMM=;x9IhoNxx3OOwkHf3GezxGktXjj4
 xJ9MMECBYMr2QIfcCfR5vH/OOXfiMqCjRANOcuWAJuVU7EzZjAWLV/GD3BbPqD+YFj/dk0P2N
 WhVxbk57IbJYD/IdFPhvrnRAx4yOpXilxFayHjnQD0/qeRW/kkAdH+szEpjY8uLtZtWApS5c/
 zhM6cLRTG1/OSDmcp0rJWdV13MHAfD7MQDZTC0i9mb75TEmmBuxo/ycaYdzq9ZMj7XDxXHDTr
 vCl3XJAscv75WrG3RxhUT6cgGQybG2dTZK9BnPNf8+mpKzAaA6jNeAmzuBD3iRwKQ4Zo3/wKh
 8sjqueEUhY8ytWOLFjb5Kf5jBJYMHjyFpGJHU+3lBu9JnEHu5h7feCsH+9hoDO1tm6EvpavCX
 JmdLYbE6kDWzQqIexMhAYTv2goJSOikV8zUlG7L2v/voHvTTFk8dus7wNzGrH4Us+52MyN2tP
 q/i/B0m9hpYyytBATvr9AInudRM4JxjNgxQ0cfYGqbV4UrmF7lhak8AdiUmguh1rwODAYCZXQ
 Wduv//+3yIXuCSLAD9DYW4KvMR8sq+ORsxBnIYNxzyK8VoZroUfn5qCTC5E+V0ZkMQY0uBBtR
 +xvjtuJ9FEXmC+IZk4lcok1ILlNnBYlilYJwi+en/9Ms8BffXtOZISfxCRrPqdtnprdt+1bsx
 yjThiMi2ihvahzTJecZMY0UTOm+8zd1XxbfUf6r9uOIJqy23TR2/pEMryvJEwy3OL+y7ZeOW5
 aSBGerSe1Yf/Ty442rBL2/N3/Bmfibnpsead0BjOSk/0lPMKGQkT2zABExcg+2HP7P7SpbBgY
 E+ScSKSuNY8cJRnXuDQp5B4BpMvPQ2wNO/D/T8MkYaDISlFoqCwSJ409JS7lx+i0V5UzOXMHK
 8HoZWjFgJyDtSynI0ZiGyDYigDjaR02zRwJ2+v/aJcBCpcqBIojT0wtaZhELLhATCjdQLNDey
 PzmzFr3tNBDgcgwhBcmxpNYfIIY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.13-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

