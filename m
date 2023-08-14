Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A599077B916
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjHNMyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHNMyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:54:36 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A75CE52
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692017674;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QTPk7pbh8xTQpBM8fRKSrfmUYK2NKmUfK/LUJ+iWwT8=;
  b=W2rY8UW07cbGSGOq1HdsF2j/Mwc9lZ+hYYhygfVAsGfqw+VO4VzlVqvC
   YYuBi/7KUGJfGMZPEO1DU0ndd8zXmOQAVzS4Vt4HrE9M6MlxLfhnyyv/m
   i3KXzJTJWhnBmM6/GBViyh2lQtIVwcl1zSF0fxz/f3tVto0pCROqx3L4A
   Y=;
X-IronPort-RemoteIP: 104.47.58.100
X-IronPort-MID: 118702493
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:ZTqXfKII8LE+3Tl8FE+RXpQlxSXFcZb7ZxGr2PjKsXjdYENS3zQGx
 msWXTuFbq7eMGv9c9pyb96y801Xu5CDnYdjGwRlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrawP9TlK6q4mhA7gViPakjUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5bJ2sT0
 fM0EQkJMBuppMW6yoCDQ+9V05FLwMnDZOvzu1lG5BSAVbMKZM6GRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/dnpTGLlGSd05C0WDbRUvWMSd9YgQCzo
 WXe8n6iKhobKMae2XyO9XfEaurnxHqrB9pISOzjnhJsqGTK71ceSwwIb1n4g/+DtR6OHMJ7D
 ENBr0LCqoB3riRHVOLVRxCkrWSWlh8aVcBZH+Az5EeK0KW8yxbJWEAHQyRHZdhgs9U5LRQu1
 1mUj5bqCCZpvbm9V32Q7PGXoCm0NCxTKnUNDQcoRBUE75/AqZk3hxTnR9NvVqWyi7XdGyn3w
 jWAqyUWhLgJi8MPkaKh8jjvjCihqZvJZgo04BjHUGW46A9weI+iYcqv81ezxfBBL8CTSUOAp
 38as9OD9+1IBpaI/BFhW80IFbCtovqAbjvVhAc3G4F7rmz1vXm+YYpX/TdyYl9zNdoJciPoZ
 0mVvh5N4JhUPz2haqofj5+NNvnGBJPITbzNPs04pPIXCnStXGdrJB1TWHM=
IronPort-HdrOrdr: A9a23:gmEVNqDPw/S5YpvlHejXsceALOsnbusQ8zAXPo5KOHhom62j5r
 STdZEgvnHJYVkqOE3I5urwR5VoLUm8yXcX2/hiAV7dZniFhILAFugLh7cKqAeQeBEWmNQtsJ
 uJeMBFeaPN5TARt6rHCGLTKbkdKBbsys2VrNab9lMoaTxDL5hn6QIRMHfvLqW1LjM2dKbQ0P
 Cnl7l6T//LQwVmUi3BPAhjY8Hz4+fTkY7gY1ovHgdP0nj3sRqYrITiFgSe3FM0TzNLzN4ZgB
 T4uj283Lynr/a4jjjV02O71eUxpPLRjuFbAdCKiIwyNDLhkW+TFf1ccozHhikxvOasrGwLvb
 D30mwdFvU20WrVYma25SHgwBbtyxEn73OK8y7jvVLT5fbhQS48CY5/iZlCch3fgnBQwe1B7A
 ==
X-Talos-CUID: 9a23:aSUJNmOV+mQ5qu5DdA9tqWobNvkcdiPW5lT3L0WKMW9vcejA
X-Talos-MUID: 9a23:5IQRGgm1tiZkF06I8IFNdnpbbe5T7ue/FnoP0rcAgfbUBWtgHxCS2WE=
X-IronPort-AV: E=Sophos;i="6.01,172,1684814400"; 
   d="scan'208";a="118702493"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2023 08:54:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITt5g/rZ1npPZzugkkYcxUV8oX03h6epQFAP+RAd85ABaLY8IWm2HRMFFsr1NvfHGN6b/2zmtr7xk8Nvrsz9NEPS9ZfzEDksTR7+Lk2NUF3JuDXyZEZuOxVWOQzWHiFfvcsASyO6pyclcWfsMDgxO107eaA6PRQxUmgryMb4o50FYVvWy43aZDT4t94CYV2xzgiBbuyMuQ2Lt/jy1qTDgjuRidCGRIX9y1s6F9R2ddepAx4UL/z9I9MDfVxAXeftgMst71oKb7UKzKR9YQmOXbx8sFh+XVGiPFi1r5D887Q8JKZI3+aAFyJsRBBelQ+RUe3Q5oKXs3bZQoUwBx7NvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTPk7pbh8xTQpBM8fRKSrfmUYK2NKmUfK/LUJ+iWwT8=;
 b=nVAUVc4vg3CFVSordt3XLfbrvtYWTePQ4u8C+JV09BSavbd1EXI2hVRHba13pK13DQDd6pjHvVZBZtNZKIaW898h9Uhjk4pcRmzoEoMSQkKE9XG2ABk7fP+j1wu8wUxE8077ZDPFctl2M9w3UFsH9/vdnqm6m1pBL8oDmaX2Hc/JoEnSxIswoZql5GuKeeW+JtsnUnYTP57fw72hzPvZW37xUOMLF3v5wTS9dNUjkguLqgG6VyUTebfjqLLgaPRj23mjPJ6QeXTG6BPQZswa5oMd/FAcJCPI3/EAgfVO1z+jRLB+jpXwihihDa3v+zFwkgkmE/aMGEdKqCuZwQ4/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTPk7pbh8xTQpBM8fRKSrfmUYK2NKmUfK/LUJ+iWwT8=;
 b=IbBNh1shpU5hvqQJM5e7LB4uJsp0MZFiw1f1Ib3Fgy6AftYKn5ExQAbanbtbqalabca0kC/AQDT8KzT649arPzFwfCnsQQ8dDsb8wqspDrTh0JA5AgditGGC4LqkvMUgjzYvnbFPq0fEVQDaDlVUBy343+zFjbqL1MWDKwgYu3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DS7PR03MB5496.namprd03.prod.outlook.com (2603:10b6:5:2c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 12:54:32 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912%5]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 12:54:31 +0000
Message-ID: <1d6e5dee-9c7a-65cb-3b39-d6f3c1f29e9d@citrix.com>
Date:   Mon, 14 Aug 2023 13:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew.Cooper3@citrix.com
Subject: Re: [PATCH v2 03/11] objtool/x86: Fix SRSO mess
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
References: <20230814114426.057251214@infradead.org>
 <20230814121148.704502245@infradead.org>
In-Reply-To: <20230814121148.704502245@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0196.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::21) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|DS7PR03MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: 524f4a86-aeda-472e-1b8a-08db9cc59a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6AMzfR9GUVjwFp0MMZe0IYQ5svcXmAfYsAG2UdshPTTiR8o4jRJL8zygyCBxhuT4X0viBaFQ/aeMtrx7KCoRnz+ayJF6ROJ8IYYEkpfLKOcKIQs4UYnmCvsXY9th6J2ulB06bUr8utZPHjhxh6LRKjSRoyM90nuUMDj8MA6wY8uIqr98ogoW4bXkVLhxfyNyGIJvD/whDT2yBYzbWOY9RziKUXrFxzKguQHljpjIskPKtorzgqwuMqcRa+nKumIoPNre6PwK3Ruh9+sS2IQW030bC1NAjxWV0tkGVoXI4VBLM0HA2FMo9U1sqVn34+L2yjQNA2WljIu0HOWbEFXomevJQf0aWVojTZBY2gTJakYzK+BksffX2J5CHmEdtTElPe3zYtRxMLffpfObHbCatWo+vspycS6NtsoZrqfwiYWlXIy38kuydBOr03FrEFrg2TlrnY4el4r06V3DAX10kqHXfvQ7+SMTmLzyVuUTH8m7qY+R30kVvJGJIDBil+rZJHqU7FAMuBT/76HQtNDHLMQIDr54EuRew2PmrIRddCgCeYrn4w1HPH8TDQthMlYsLmokIWDcXWrThCi2QLWhUiUN4IKtottKh+J7wiEU9yVHAL+pMogj2z1F2ibnT7YCxPJ1EFUti0LU9R6b7/Z65aqvBQeGEw0Jit+eBGOL1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(66899021)(478600001)(82960400001)(6666004)(8936002)(8676002)(66946007)(66556008)(66476007)(316002)(41300700001)(38100700002)(9686003)(6512007)(6486002)(6506007)(53546011)(26005)(2616005)(4326008)(86362001)(4744005)(2906002)(31696002)(5660300002)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODdhZmdUbHlENmJyWWVITXhWQVpXa3RrVkFmd0dVVkFiZGxSd1B6THBlVFVl?=
 =?utf-8?B?Sk1maWQ3bzg4UDB4NUlFZTR5MUdJdjF6R2lydTZXZ3YvTDl0QzkyQ1NVZ0Fs?=
 =?utf-8?B?QzhvclBCc0l5b0MraDRDUGJNaW5KT1RGR2FvNkNOT3VUUUg4a0lGM3FYOFZN?=
 =?utf-8?B?dnlhemdzZTNGN1FNN0duTFJuMnBSblhqbnNhaEpMZFdWaDEwU21pWVFyL2cx?=
 =?utf-8?B?S21BUHEvazlJVmlWczZPWVRIWjgrMGs5dW1HM0R2ZFFaMG9BNDJ5U0UzUG03?=
 =?utf-8?B?TXdCeXRRMUJxKzFIdk1EY3BkNk5kTitCM0VkM1BVdUVFUlg2U2N2a29TbkpF?=
 =?utf-8?B?N294Yi9Md095NllBZUdXWHFWdEtwVWNWYjAvR01NWk16RWtkdWNJUkZweFUw?=
 =?utf-8?B?Yk9GTVBoR1EzSGJmZDBHQnFGMWZ4Q0toUHBnRkwrZTRORm1DQTM4U1pVY3h4?=
 =?utf-8?B?cytpVXUrSkRaZzNlRHVyV3lmdS9ObWhqVWk5eFNjdThpQzdmMDVzTmlhd2Nh?=
 =?utf-8?B?eGZZbXdtMGltbkQwcmpnWDBsQ0VDZzJEVXdWczl1MUtmZEovekRtYlVMNjFw?=
 =?utf-8?B?LzhCN1JKci94aFN4KzJTbCtIaTVsdDRzOUpjdkR6U3c1ajlQZnA4UnZYOWVo?=
 =?utf-8?B?RjNnQ2s1T0p4YlRlMXdaV2RZQ3NEWFhqOVVyODZaT3ZHYjB6NU1HejF3RXpk?=
 =?utf-8?B?MGFucy9SeDZpUlJ6ZFkyWVk4QWlJZ3JBa1lwYmVVTXhyTUxvczIwYmpDeHVU?=
 =?utf-8?B?eFU2c2loMDNnMUtOcE5IcUFSM0NOTEd1NXV0RlVJMnY4OHJ2b1ZCc1NPcXBL?=
 =?utf-8?B?QkxhdFd4Rk5CRVZTYkFvOXNoVjY4N2l6TTZpdzcwS3VTUzdFaFRFQXFRV1hH?=
 =?utf-8?B?eHlrUkpyeUtHdXpEb2lyUTgxdTI3Zkt4c3h2R21GRU9lUEZUemgrcFhwSmJt?=
 =?utf-8?B?Q1BOWTZzcWFXQ0NEaHQzRHlZa2NxSlAxK3IzVng5U3Z1emJqRVdpbXRSR3JP?=
 =?utf-8?B?eGtJSm14OFlhZTdCbW9IRDRlUFlYZDVBK0lxQjFSalZxUTZBNVRyYWxxaVhJ?=
 =?utf-8?B?bFlBL3JuMEpYajgxclJsQ0RxMjhseHZPc1Y0eXFVNUtSYVJRQ1U1cHNFRVVL?=
 =?utf-8?B?ZXV3Vm1NWDI3OGxyeUVXS2NPVTNYY25uWFlSL0NmTnUrcmNTM0xGVXdFS3pj?=
 =?utf-8?B?QnhvUHh2YzNGUHMwZzl2YmJJOEg3T2F4MC9DOStXa2M5VGpVOEJBSFc2VWVJ?=
 =?utf-8?B?anh6cGlmV2JseHZiQWNPZFVCTy9kREMvSm1uTnZab09TbjlKVEpsZzRmMVFG?=
 =?utf-8?B?MmRGUjBNTERmc0s3UG5MWnZDVVIrOGJpNzhTckNteE5ZUmtFaFhxZjZBTjJ0?=
 =?utf-8?B?ZUUzMm1oMVZUQWQwWWxHZVQybVdQYnRkMGlGY3BodURZSnNyelRLTkN6ZFQr?=
 =?utf-8?B?dDNORUhCNlJmV3RaakkyWk1hQW1VQlBzeFVjT0ZkT0t6WjJhdk0zeU1JUkNp?=
 =?utf-8?B?enRrV3VwRWxJN29iTy96dC9FS1BQM0JQUVJXeG14TmxYT0o0SWRQd2J4SjdX?=
 =?utf-8?B?TFdLNWwzcFNrOGFUVk5lakRwKytGTm5JWW5rbTBRajl0V0JoZEFXNlkzaWRm?=
 =?utf-8?B?b244ZVU3UTF2MFFoY3g1MUFzYzdDZmgxdUNmdGh0VGZ0WVVLS3JueEt6K1NT?=
 =?utf-8?B?QU5rRU1wazVrc3cxQjUwWXRWMWxXb090alhzeTJrVnBRRXhGWVVVazRWL0x0?=
 =?utf-8?B?NnNsdEVSdUt0U1RHanZUUDR6SCsrQVp1N1ZabkJzL1JWQTBzcjB5N2ZzUFNT?=
 =?utf-8?B?QVJ2T2dUUmhTNjA0amFOZ3BjOHhNYjRNSnJRalpwNHRORUJZN1Nhc1pFeGZm?=
 =?utf-8?B?aVVQRDZVV1pEeGE5MzRpVFIvVUQyMmlmOU1aSktpTE5ZVEV4VUxJcnhpTDBl?=
 =?utf-8?B?aVJGcm9qbjdRWVcwZER5ZEkwY1NKeXZtdWRFS2RWditUU0ZDZTFQSnE4N1Vp?=
 =?utf-8?B?QndsSWExdURBTjdpcU1FNEFOWk5wOGF1Zi84QVJmakh2M3ZjdGJEb090dklS?=
 =?utf-8?B?dHJIRnl1NVZHY0JrN1ZpWmZVZkowdGMvakhDZVdVcUI2WW5HY3k4aGFpam9j?=
 =?utf-8?B?bGNneHh1VVc2OHRsaklBUDE4Q0NWQVFiVVhHK1ZtWlV4MmxvRVhaaHVaZ3dS?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OHRCNEJYQUV5RXc5YzRsakxLN0ZFSmYvUVhpR3ZhUXhaL1JJd0VnM2xFMlFO?=
 =?utf-8?B?TW0wQzJBcThOdkE5dWcrcHc4OWoraEc1WVpRMVFTSDZ3RGNxM1JBQnVCYnRj?=
 =?utf-8?B?eDFnRlpLNytGbHNuRllCWkFZczFUNzZpV05EQm4wTkN2d2VvWXlycTBNMG14?=
 =?utf-8?B?KzA3cmREREFJVDA1VjJJMXo2MEpFK1RseWFzMXhuUXkxVjExNFloT3dNLzdM?=
 =?utf-8?B?alNGRnd4dWx4c1dYbWpBNG9LRWFBUGVhVm9TTmxETWNCNitUMjE4SEpudzV1?=
 =?utf-8?B?Tlozck0wd3F5c21hY2g1U2tnK0xWMndmM1dBeERWVFkrTkJyYjdYclNPeUFD?=
 =?utf-8?B?MGwycm1QVm9ibUNodHF4cE53YU5KT3dKV1Y3UzhNZ3FSZCszdy8zaVE1eU9v?=
 =?utf-8?B?SWExMXVrUHpFMjBORnUxUHdveFdUT0lZdVBZVHF1MVFqYWc3eEs5dDVVZmpM?=
 =?utf-8?B?UEpCNC9SMUVkNVU0ZkN3cFgva0NRT1NIUFpLVkFsR1VwVjY4WDFEcGt5R05m?=
 =?utf-8?B?SjBVb0ZVVkl5RjNZVkFhbld1bWtFT1lyR0hIaWFWQzlmMXMrZ0pZSzdFeVBB?=
 =?utf-8?B?b2gxcUkzbWFBaUdWSy9PSWdzVFloUHBrV2UwTktTeFVmVkxCSnQvbXltbFlK?=
 =?utf-8?B?Q3RuRDdNblBNam55b1daWnN1TzlYT1Q4Wm9NL1BQM1J3VWRYQ1lVdlJXV3dm?=
 =?utf-8?B?YVhPbDNoQlZzTlhhZDNPejBNV1Y2Q2hzQWNVeDdDSldmekd6SVRYd0IwUzVV?=
 =?utf-8?B?VUhSZ1BBWFZ5UWNEQXlxTnRiQjlPMkszbHZ4aVgvb2dNNHc3SEo1SlFjTXJG?=
 =?utf-8?B?NXRtNHBVVHd1TFlsajJiYWlLdC9zeFBRdW1uSjBOSXVvZktIZFQzNzdKaFhq?=
 =?utf-8?B?NVdma0pmclo4NDRZYzF2eEpzS3FzREZZVnlvZUJyNVlHckVUWlRYUGdlWnJE?=
 =?utf-8?B?Zk9JSndjUURibVl2NnlXa045cTdDdlJPTmN1UXJ2V2JuUXVLaW02b2lKQ3VW?=
 =?utf-8?B?YmxmSTdsVUNhR2loakxnVmVKQ2dGWnpQeThJT0RnVmpaYUw0bXdWS2JoQ3N0?=
 =?utf-8?B?UE9URVh2TjJ6N2NkRFcrN0gwK0tvcmZzOGs2eElwOTRJREd3UGZqOVpFa1RC?=
 =?utf-8?B?N29qQVlrU3UzQzJONVJ3TmVHTWhHalNlQUxESk5ab2VCWVkreEVURk50YTI0?=
 =?utf-8?B?OWNCenRtTEt3Y0JTNGxQTWxWd3ozeDNnNzl3MFBjTS9BN1pRRkFoRzY0ekt5?=
 =?utf-8?Q?PlcMdAyw4heJ0uh?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524f4a86-aeda-472e-1b8a-08db9cc59a42
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 12:54:31.7048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KURTeIHgZj58Y7KGerb4nA4fRmiKtkRFU6+Uj858+a+BjX1F7sX4iEs1bbEEhDxHpQ8UUN26jhYR7clkvX+1w+9jlHZDOKXYji0/z5MQi5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5496
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 12:44 pm, Peter Zijlstra wrote:
> <snip>
> +/*
> + * Symbols that are embedded inside other instructions, because sometimes crazy
> + * code exists. These are mostly ignored for validation purposes.

I feel this comment still doesn't get across the sweat and tears
involved with the fixes, so offer this alternative for consideration:

", because sometimes the only thing more crazy than hardware behaviour
is what we have to do in software to mitigate"

~Andrew
