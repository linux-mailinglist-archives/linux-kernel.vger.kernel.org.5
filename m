Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A177CD6D4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjJRIoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjJRIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:44:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EB1F7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:44:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I74DLW023478;
        Wed, 18 Oct 2023 08:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xLCEhXicVP2/HIwaodmutx62JgaH16PJFG++EBo6etM=;
 b=oExvf4CSzl0+BO67f9AzAqBe19k5TkjPik2nwqFinZRLkSTPqadtMbaI14oStqR+5D3/
 BHjkbip52SFH6Vx/vYBBh4bS6FQAgteldu4lsd5SmJUPh9HYbTRItufACAGIsnYL6P3I
 co8/MwszbpVoSHb4Rj6XG7bn15PNYco3sTyJEd+p5D7PKDWP/uOe+iY7zmEMyoNlWHxl
 zV0ZAejWVV1xuzUpKankvvFTlaE2ddvc6JuyfJZPDJo9fBFzmNOiTACRYccxMhegOeTE
 8j7oh1imr8tpBJMHUqhMDj6a0t2LGM3kI9Amz3VZzgVp6F11o4lwv+yfGfeQ5XlChGaa 3A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu71un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 08:44:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39I7NLPS027127;
        Wed, 18 Oct 2023 08:44:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg55034e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 08:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y78t5Y94CBDgZ/XQypEdG7Orkkocn3znGmAFUR5BdiJpPiD+X2tWv4ZqjRl5CJi7uMqAyJlO0lG72Kq2VHsOkMss4mZzEq4pbbNFuPnsh60JlDG4oIHhx0YuF2IWoW0eRVuzcf0Xy4eTTurlSP9AuDJLy8/MkkrdoEQgj5185sDV+mWiYulckmJpYmyPuKP/w8QTGaHb/s1gw7ERaqxVjmW3NbaZvWfD5AMrWdIrruMj/qKjHrx6sH7pq59kVTjG7goMRh3chC334L5lPLeFZBXgUH9OMAaNY1LBowH57iMdO/kuxdpP/OBXWRnVCoAc4HI6oYOVsLkTtNPZ2I/nhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLCEhXicVP2/HIwaodmutx62JgaH16PJFG++EBo6etM=;
 b=eg0d0o1a/ESzNZUHofSVscwr/oR+HgSWi7Ho9qVyI4VZe2orm7QRJoITiBqux2Vy+PswXJoMDwx9ZgnW4VxD+oA35elWKqfa0HSJb7wkizUHXxC6Q/sS8Mg+xXd0cRGvu3GJahxJQvfT3tdxpASQRl12mtXyC/pVkvWdhHmt9N65/htcP70n5e2jTcflpQcljjKR0NwiHs9WO7GH3UQqpQr9nwSuCBW78EldbufxpxWGO/6E84UE54Soy94yiEgbYDWo9OgyuVoyuAyoE0LY9AJoyt3KQXlCd2q7hpIdsNRts8i0+LdDEMPThSf/cvqEehEmaiK/MLRCCcXu/GEQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLCEhXicVP2/HIwaodmutx62JgaH16PJFG++EBo6etM=;
 b=rl9xZ+lNoxHpayx0ZE1ItP+a9OaMowRUMma8U3bxWxBF0oMIal8pqqjSROBoUyPHb+XFaoh/trjtN4vgmY+NMdqDjetc/hTc74zxOHtizCH+fVE1uzsypySXv4pIez2ZWZgwj1FovHnz5JcYRp1ShUCm4U0vdwleYSb/WbDKKTI=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:da::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Wed, 18 Oct 2023 08:44:05 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 08:44:05 +0000
Message-ID: <9c74b299-98ec-46b3-bf21-972f9883ca84@oracle.com>
Date:   Wed, 18 Oct 2023 01:44:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
 <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
 <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 669c63a7-9f65-4d25-2cf8-08dbcfb6630d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTh38xbHhVGLQ4yjMnd3coLS+mkrZXbB45Fqy0UzXKU0IHm6JHmysnvH8C59aobWscnCyu+duajo4YF/FnDruBTnCZfJz/PH/dTItDfiMAsGWlAOoz0bwwcuusmONM74LmDTpAJ4U3c0OO0oZzS/orHTTnrmtlOetEl1VRCVFFQ7v8sYv0s1nLlputWeOHtNk8ieC0aWeO7ER6lOxY11km8PqvM2Y6in1ZI445Ff2H0TJZCuHOoATmOakakgl+q8gFf8Usw1zMKgGzzOjMWNWBqnUW9J/CZnUT+ORFdTCbKna7V/Nd0pSQNwTNXFBmFWF7lnyXhmwJuS7DrjVb8RIt6zo8cNgZnMIHPPZ7DmcL3Al1EccLtObtxjcwVIEN6egwjJMQUPxYDkPbxpN7/5A3n6nBMHA1Y15H/ndPbLBJj6WSz+1qctv646qZJ0eOLxmE3QRBD5ZKhnqdmkV9pFjPrke4V66O1Eo2zzEc5wozzHQwNQLzLgzNho7n6frQa14e1jRXuO89Tr4STIpNgMds/ZUuIABMUcd9UUaY8ivYbsQGWL/qmdRfV0QTiWav62T4bql+njSkQi6SGRQspJlNoKEzPutH0tQ1S3EkXq9286kynUyja2q6PsDE97QWfV/bg92wnIm6MOxe0oFLbaaIedH3Dqvdr76Z7T12E5Re/jiEgr1Wr7nTboY8pPTBGjgbT04OpSejogeXLd394YeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(6486002)(966005)(6666004)(66899024)(38100700002)(66556008)(316002)(66476007)(6916009)(66946007)(31696002)(8676002)(36756003)(2906002)(86362001)(4326008)(41300700001)(5660300002)(8936002)(30864003)(83380400001)(26005)(2616005)(31686004)(36916002)(6506007)(6512007)(53546011)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2VuRVc5ZWFzYnI4R1VuakxlakJLSFlGU2djeDMybDViZVA2MEw0dGI3SDZD?=
 =?utf-8?B?K2grbjd5VGFSYmxncm1qbk5TcjJKVXZBcUxWcit3ZjI2bVgrYTdaMWJnWm9W?=
 =?utf-8?B?ZUtubVZIU1hrcGdiRWZHelJiWFRYRm8wa1ZhNFB5L2lEWHNFWGVaUEdMVzlr?=
 =?utf-8?B?V2ZGWjVrS3dnVmY2aThWTmtuQjBJMVlqVzNyZ1JyRm42T05KTXBVSVRKbEhp?=
 =?utf-8?B?eGQwQUR0dmQ1Qk5yTUdXc3pMbnFZMjBzNCszRXVRQ2UvQUE2TDVyeGU4eFZz?=
 =?utf-8?B?Z1U2aFhLSERZK2dKWFViTkdOWlh6RDE3MVNMbWFFSDlXd3ZpamkzUzNkam9X?=
 =?utf-8?B?SlU5N3UvMlh3V05ZRlFpeHRHaDd1ZmlzbnljWW55YUhSWXFhNExabCtxaVRB?=
 =?utf-8?B?NEZRUHZiQkJFdFdrdWdzZFZxSkxqTWsraXMrSW1mdGxwVGlRUTUwN1M4L2U0?=
 =?utf-8?B?VVZCQ08xTWFhV29Uc002bTFUL1JkTHdOb1I1TkpqYWEwc2Rnc3dCZjVuOHF4?=
 =?utf-8?B?ODdsUDNDRzU5dnFRQ1J6SHI4N08vWlduMENvenNhK2d6R0M2bmNlZzc5K0hC?=
 =?utf-8?B?dFIvdTQwU0Y2WGpFTzJCZFNvN2tNRm02L2luMVdWQWZ3a3BoVG9aRlB5V0tp?=
 =?utf-8?B?eUh0MTkvK011bVZRdFV4SHNIRkE2bkZ3cmhYYjlyamVaRjBza3VPamxnT283?=
 =?utf-8?B?RG1xLzZ2d25hVVpVZlJhVzNjdW81N3M0YllFYmpYY1JIQVZKRXR5NEVRWGg4?=
 =?utf-8?B?enNNMm5hVFdNOXNXeTBQQTBTUG5TRVY5Mm8xbWo3Z2tOMkoyN0Q3dkRFdVgx?=
 =?utf-8?B?TGRhZXEveEs0UzJxM0R1dHczMUphaFVmZnJJa0VWc1FHVWpaRDdySDRhM3hQ?=
 =?utf-8?B?R0c5dmQ2eXVWaWVtSkVMbjdzV3lQTkRwN1F3bWdTUWtML20va2NqMXI3N1Fx?=
 =?utf-8?B?V0wwcHBNNm41N2lqTjIwNzRiS2VtYzhYM044RkIzZzYvMFBOdWdpdDd5aXNJ?=
 =?utf-8?B?QVRzQjg4MHczRVNaTmJCeUJrM2VUd3pJdGpabEkweXIyQnViaU9KYU5LdkVJ?=
 =?utf-8?B?NnZCUzlQVGl3TndNcC9BaDlqeExUZWhzSGxBWWduMFBFVVRQVHp4dXo1V0Q1?=
 =?utf-8?B?TGZlK0pGbGZyWThqUVoyQnUwOFY0emdkUGVaUUJnOHJoUHlBWjJadVhCWUl2?=
 =?utf-8?B?UFUrdUhxZHltempiQStCTWs2dDZrOGdHUjlvZll6dkljb1lIeHp0eHdJMmMw?=
 =?utf-8?B?SERKdElOaVMxOXI1c1lMTFpqS09pVWR2M3k2cjluZmZGYkszRVd6R0N0OGps?=
 =?utf-8?B?cS9zRDd6c2lJa3kvVnZXWFp6NGZQeEdPUTlNNlBFb3RQUjJCdkFwWFJVYXFG?=
 =?utf-8?B?aXZwTldDNy9KWERJbEx2dkRodnN5VGRseEx3bXIza3dDdkRSN0UwVkZRNHo4?=
 =?utf-8?B?REJQdnZSWjZjZVEzV3owZDBLa2JOaTR4ak9xZE5BRnc0NzMrU3FHaGNidEgz?=
 =?utf-8?B?bmFnU2ZoSVAwaXR0TFhHVjA4YVRmWVVBTWxIVnhPaU9ObEFNaTBMdDJXbldZ?=
 =?utf-8?B?clQ0elhqL1kzRDVaUHlqZmdZbkJJUWtSYk1NZUVOTXViQVdkQWw4Y0R2OHVD?=
 =?utf-8?B?SWJURU1XK2QyZll5MGQ0UFRqYWVzWXIrbHZmeS9USUVyazdLd2cwNkx5eENT?=
 =?utf-8?B?M2lEeVczQ0d3S1ZLVDhGdTdvY3RtOGZibFpmT1dxeUFsMk42RjBOeWc0enpM?=
 =?utf-8?B?Q0UzbFV2TWl6cWJreGNoZkFobjdmNHhPaTdQUDJVMmlGZHlVWGhzSDNiQzFP?=
 =?utf-8?B?M2JJTmxOd1RDV2tWMnBSZW80YUtxYko3aU9XMm8zeGUzTytLMWQ5TU5tSXFR?=
 =?utf-8?B?S3Fnclp3Ny9rUDV6VWJuU0ZsK3JFTnNwUnBvTFB3cXp6ZFl6V0VDcVZrTVZz?=
 =?utf-8?B?TlkxK0dXMFVLU01SMXRsdkg1eWdkYWk1YWUzNUdLMm1RR3ZZSWxoS29WYTc2?=
 =?utf-8?B?NWk4clZNTWV6TTNvM2RiYzdybUNlU0dQTmJlcHhLb1dldmlTYmZLNDVyNVlQ?=
 =?utf-8?B?Y0syKzY2QkFNQitzUlRCR0o5N1IyK05HUU5oVTdEVmlwU2Nyd3oxSDdscVV2?=
 =?utf-8?Q?4MATJ1cZbSToXsaB9vmwiJ3s9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WmFDSU4rR1BxRUY5YzhRbmo1OGZHcU9CUzRLM2hSNmFTc1JmRlZESFZ2YTh2?=
 =?utf-8?B?b0Y2ZkphcERHNHUwQ2N2VCtmK0U2eFBYZjVMQ1dxQ0VGMEdIenk3dUVpaDc5?=
 =?utf-8?B?WUl6amFkajRORHIzNWMvVWhjYVR4QXMxc3YxNXNYMmJWOWJVUGM4RzF2bWxK?=
 =?utf-8?B?YTFna2JFdHpNTzdLNGlGK1VIRWdCVHdDTDZUamUwcFNadjBFVTFCUGxGWGR0?=
 =?utf-8?B?Q1FYSklwbW1wN3JWV0FJVTNNQTRmUEx5NS9POVpoNEQ4Y290SkxYWWx5TXdn?=
 =?utf-8?B?QkJOckxCWXAwVG1wbkt0SUQ2cnFWc0dxRkZjSGdReXFQcDZVT2JNV1NYZzJ4?=
 =?utf-8?B?OWFDT1RETjk1ZVVuSVBhaG1PRWF3eTFvNjUwb0lEVUtVQzlSTUdocy9sbWg5?=
 =?utf-8?B?dGlLZ3BxUGhqdGRrd05mS1dYRDg4cklXNkhvVUtOOFVuK1pNMndDUnRKakww?=
 =?utf-8?B?djBSU3dBQXZaeFVTVGg1TERuODNGV01LdEpJVCsyNnk3MnkycEdGd2ZPQmxi?=
 =?utf-8?B?SUFka2ZGNEdCYWNCNWN2QWxyNVRRdjFQNTQ4WmpTRktqSHh5TWxLelBzUEFl?=
 =?utf-8?B?Y2h3UTc1V3RCVi9hZU9pYU4yRGtMcjhmVXV1VGZRV0JYS0puTTZvalhvNnZt?=
 =?utf-8?B?OUNabmYxaG9UWk9kSWVveklxWi9BVTFucHFYdFZFS1BnTmVnZUpVSmJ6Z3Ns?=
 =?utf-8?B?V0MweW9KdEFVRUQrZU1xbzVua25IOVpyRmZXTGV2aHp1N1h4eVYwa2VJY1po?=
 =?utf-8?B?UFpOVTNBbytkMVk3V0RKL1dsSHY3SEgyb0RjV0cxQ3RzWlpZZ25tdUlvSFJj?=
 =?utf-8?B?MnFXWXRqUy9OSGc5NXFuSTFDbFlFVllNbUp1VHB6WDJpbnp2UWhzTWkxbElh?=
 =?utf-8?B?bDRibmdWRkZWN1JyeGR3aTJhSDIvVnR4T3ZlQ0tNOUlGS1BEUm9sR1R1Zkhj?=
 =?utf-8?B?QXU1cE5DUEtmdm91YUh6bEdLZ1o3MEFPSFI3bnZDN2IwMG84UTF6WTdKU2Zt?=
 =?utf-8?B?VEdIcXowK3YvMld4bWpUV0N2R2RnazduaXg0dDFvMVhDSitnOEpta3BEUEJL?=
 =?utf-8?B?aytjWkoxV0ZWblRlSzQrT1E4czlPRXhjOHVlaUttWmVEYyt6VEdIbEcvYm9p?=
 =?utf-8?B?dzk4SFFVR0lneXQwWmFPWFlScDdic3BYTVN1c3NsbCtlYW1VQ1plYlJ3dlNt?=
 =?utf-8?B?THVzN2xKa2l5L1FkQnF6dUxTbzB2S0d4SVB6NVVzWCswai9OYTRUN3pEYS96?=
 =?utf-8?Q?HFImm196D5vJcOW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669c63a7-9f65-4d25-2cf8-08dbcfb6630d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 08:44:05.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MT9gw0hv+G4chDUOeQKvtQPaeOxGTvCp5mdlwJMQo9zFUM0GYIRaX+aFbPMi8GZc40TT4UtuKHDcx4YNTcN7nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180073
X-Proofpoint-GUID: L90nBewsr5Fg6CMzhh0rMF9Z4sciKq6S
X-Proofpoint-ORIG-GUID: L90nBewsr5Fg6CMzhh0rMF9Z4sciKq6S
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2023 10:27 PM, Jason Wang wrote:
> On Wed, Oct 18, 2023 at 12:36 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 10/16/2023 7:35 PM, Jason Wang wrote:
>>> On Tue, Oct 17, 2023 at 4:30 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 10/16/2023 4:28 AM, Eugenio Perez Martin wrote:
>>>>> On Mon, Oct 16, 2023 at 8:33 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>> On Fri, Oct 13, 2023 at 3:36 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>> On 10/12/2023 8:01 PM, Jason Wang wrote:
>>>>>>>> On Tue, Oct 10, 2023 at 5:05 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>> Devices with on-chip IOMMU or vendor specific IOTLB implementation
>>>>>>>>> may need to restore iotlb mapping to the initial or default state
>>>>>>>>> using the .reset_map op, as it's desirable for some parent devices
>>>>>>>>> to solely manipulate mappings by its own, independent of virtio device
>>>>>>>>> state. For instance, device reset does not cause mapping go away on
>>>>>>>>> such IOTLB model in need of persistent mapping. Before vhost-vdpa
>>>>>>>>> is going away, give them a chance to reset iotlb back to the initial
>>>>>>>>> state in vhost_vdpa_cleanup().
>>>>>>>>>
>>>>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/vhost/vdpa.c | 16 ++++++++++++++++
>>>>>>>>>      1 file changed, 16 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>>>>>>> index 851535f..a3f8160 100644
>>>>>>>>> --- a/drivers/vhost/vdpa.c
>>>>>>>>> +++ b/drivers/vhost/vdpa.c
>>>>>>>>> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_alloc_as(struct vhost_vdpa *v,
>>>>>>>>>             return vhost_vdpa_alloc_as(v, asid);
>>>>>>>>>      }
>>>>>>>>>
>>>>>>>>> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
>>>>>>>>> +{
>>>>>>>>> +       struct vdpa_device *vdpa = v->vdpa;
>>>>>>>>> +       const struct vdpa_config_ops *ops = vdpa->config;
>>>>>>>>> +
>>>>>>>>> +       if (ops->reset_map)
>>>>>>>>> +               ops->reset_map(vdpa, asid);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>      static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>>>>>>>>      {
>>>>>>>>>             struct vhost_vdpa_as *as = asid_to_as(v, asid);
>>>>>>>>> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>>>>>>>>
>>>>>>>>>             hlist_del(&as->hash_link);
>>>>>>>>>             vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
>>>>>>>>> +       /*
>>>>>>>>> +        * Devices with vendor specific IOMMU may need to restore
>>>>>>>>> +        * iotlb to the initial or default state which is not done
>>>>>>>>> +        * through device reset, as the IOTLB mapping manipulation
>>>>>>>>> +        * could be decoupled from the virtio device life cycle.
>>>>>>>>> +        */
>>>>>>>> Should we do this according to whether IOTLB_PRESIST is set?
>>>>>>> Well, in theory this seems like so but it's unnecessary code change
>>>>>>> actually, as that is the way how vDPA parent behind platform IOMMU works
>>>>>>> today, and userspace doesn't break as of today. :)
>>>>>> Well, this is one question I've ever asked before. You have explained
>>>>>> that one of the reason that we don't break userspace is that they may
>>>>>> couple IOTLB reset with vDPA reset as well. One example is the Qemu.
>>>>>>
>>>>>>> As explained in previous threads [1][2], when IOTLB_PERSIST is not set
>>>>>>> it doesn't necessarily mean the iotlb will definitely be destroyed
>>>>>>> across reset (think about the platform IOMMU case), so userspace today
>>>>>>> is already tolerating enough with either good or bad IOMMU.
>>> I'm confused, how to define tolerating here?
>> Tolerating defined as QEMU has to proactively unmap before reset just to
>> workaround the driver bug (on-chip maps out of sync), unconditionally
>> for platform or on-chip. While we all know it doesn't have to do so for
>> platform IOMMU, though userspace has no means to distinguish. That said,
>> userspace is sacrificing reset time performance on platform IOMMU setup
>> just for working around buggy implementation in the other setup.
> Ok, so what you actually mean is that userspace can tolerate the "bug"
> with the performance penalty.
Right.
>
>
>>> For example, if it has tolerance, why bother?
>> I'm not sure I get the question. But I think userspace is compromising
>> because of buggy implementation in a few drivers doesn't mean we should
>> uniformly enforce such behavior for all set_map/dma_map implementations.
> This is not my point. I meant, we can fix we need a negotiation in
> order to let some "buggy" old user space to survive from the changes.
Userspace is no buggy today, how to define "buggy"? Userspace with 
tolerance could survive just fine no matter if this negotiation or buggy 
driver behavior emulation is around or not. If any userspace doesn't 
tolerate, it can work still fine on good on-chip IOMMU or platform 
IOMMU, no matter if the negotiation is around or not.
>
>>>>>> This code of
>>>>>>> not checking IOTLB_PERSIST being set is intentional, there's no point to
>>>>>>> emulate bad IOMMU behavior even for older userspace (with improper
>>>>>>> emulation to be done it would result in even worse performance).
>>> I can easily imagine a case:
>>>
>>> The old Qemu that works only with a setup like mlx5_vdpa.
>> Noted, seems to me there's no such case of a userspace implementation
>> that only works with mlx5_vdpa or its friends, but doesn't work with the
>> others e.g. platform IOMMU, or well behaving on-chip IOMMU
>> implementations.
> It's not hard to think of a case where:
>
> 1) the environment has mlx5_vdpa only
> 2) kernel doc can't have endless details, so when developing
> application, the author notice IOTLB is cleared during reset
I get it, but my question was that, even if the author had noticed IOTLB 
is cleared during reset, does he care or not to make IOTLB back working 
again? My point is that, if this old setup is supposed to "work" on 
mlx5_vdpa, then the developer must come up with sort of "quirk" to 
recover the IOTLB to make it back to working state again after the 
reset. It will be more justified to come up with the proper fix for 
compatibility/emulation only until we know what should be expected to 
work and through which possible means to making it back to work, rather 
than blindly emulate the buggy behavior solely based on a few driver's 
own implementation. I'm pretty sure there are multiple ways to implement 
the buggy reset behavior in the driver, does it mean we have to emulate 
various corrupted mapping states in the individual on-chip iommu itself? 
How is it able to help the developer user if we are able to replicate 
the same corrupted mapping state in the on-chip iommu after reset, any 
real-life user only cares about mapping being corrupted in the same way, 
rather than cares more about the quirk sequence or work around to get 
iotlb maps out of the broken state?

Only if the userspace is like a test facility to expect some test case 
to fail on mlx5_vdpa after reset -- I assume that is not real-life user 
at all.
>
>> The Unmap+remap trick around vdpa reset works totally
>> fine for platform IOMMU, except with sub-optimal performance. Other than
>> this trick, I cannot easily think of other means or iotlb message
>> sequence for userspace to recover the bogus state and make iotlb back to
>> work again after reset.
> Yes for sure, but we can't audit every user space, no?
We don't have to, as userspace here has no bug at all. The bug exists in 
the driver not in userspace. Real life userspace app only cares about 
making things work not asserting something must be broken.
>> Are we talking about hypnosis that has no real
>> basis to exist in the real world?
> Instead of trying to answer these hard questions, I would go another
> way. That is, stick to the old behaviour when IOTLB_PRESISIT is not
> set by the backend. This is much easier.
Please be noted the old (broken) behavior can vary between different 
parent driver implementations. It's driver's specific own problem, if 
there are N ways to for driver to implement buggy .reset, do we have to 
emulate N flavors of different vdpa reset behavior?

>
>>>    If we do
>>> this without a negotiation, IOTLB will not be clear but the Qemu will
>>> try to re-program the IOTLB after reset. Which will break?
>>>
>>> 1) stick the exact old behaviour with just one line of check
>> It's not just one line of check here, the old behavior emulation has to
>> be done as Eugenio illustrated in the other email.
> For vhost-vDPA it's just
>
> if (IOTLB_PERSIST is acked by userspace)
>      reset_map()
>
> For parent, it's somehow similar:
>
> during .reset()
>
> if (IOTLB_PERSIST is not acked by userspace)
>          reset_vendor_mappings()
>
> Anything I missed here?
First, the ideal fix would be to leave this reset_vendor_mappings() 
emulation code on the individual driver itself, which already has the 
broken behavior. But today there's no backend feature negotiation 
between vhost-vdpa and the parent driver. Do we want to send down the 
acked_backend_features to parent drivers?

Second, IOTLB_PERSIST is needed but not sufficient. Due to lack of 
backend feature negotiation in parent driver, if vhost-vdpa has to 
provide the old-behaviour emulation for compatibility on driver's 
behalf, it needs to be done per-driver basis. There could be good 
on-chip or vendor IOMMU implementation which doesn't clear the IOTLB in 
.reset, and vendor specific IOMMU doesn't have to provide .reset_map, we 
should allow these good driver implementations rather than 
unconditionally stick to some specific problematic behavior for every 
other good driver. Then we need a set of device flags (backend_features 
bit again?) to indicate the specific driver needs upper layer's help on 
old-behaviour emulation.

Last but not least, I'm not sure how to properly emulate 
reset_vendor_mappings() from vhost-vdpa layer. If a vendor driver has no 
.reset_map op implemented, or if .reset_map has a slightly different 
implementation than what it used to reset the iotlb in the .reset op, 
then this either becomes effectively dead code if no one ends up using, 
or the vhost-vdpa emulation is helpless and limited in scope, unable to 
cover all the cases.


>
>> In addition, the
>> emulation has to limit to those buggy drivers as I don't feel this
>> emulation should apply uniformly to all future set_map/dma_map
>> implementations.
> Unfortunately, it's a must to stick to ABI.
How come this brokenness in mlx5_vdpa becomes ABI in any sort for future 
on-chip IOMMU drivers? They might not even exist yet. Even if it's  
concerning ABI it's limited to mlx5_vdpa and the existing drivers, right?

>   I agree it's a mess but we don't have a better choice.
Well, it's your call, I can implement as you wish but the unwarranted 
code has to be maintained forever. Particularly without knowing if 
there's really such a use case in real life, and no one in future might 
dare to remove the code without knowing what it can be used for.

> Or we can fail the probe if userspace
> doesn't ack this feature.
Fail probing is even worse choice that is introducing intrusive breakage 
to the userspace.
>
>>> 2) audit all the possible cases to avoid a one line of code
>>>
>>> 1) seems much easier than 2)
>> You see it's more than just one line of code, and I'm uncertain if the
>> additional complexity is warranted or necessary, particularly if added
>> this piece of compatibility code will linger for quite a long time.
> This is a must as long as it can be noticed by userspace. Doing
> something conservative makes more sense to me.
>
>> Instead of adding hypothetical code change for no specific good reason
>> and no real use case,
> It's not adding something new or new behaviours, it's just making the
> IOTLB reset conditional based on vDPA reset.
>
>> I'd like to add the code when we find out a
>> specific use case that may get impacted or already being affected,
> It doesn't conflict with what you proposed here. Old behaviours have
> their users, no?
We don't know the use case how to make thing work instead of make thing 
break, that is the problem. We have no way to test if old-behaviour 
preserving code really works as expected. If there's no such user in 
practice, it ends up with dead code no one dares to remove.
>
>> then
>> we will have good understanding how to code up the fix and emulate
>> properly for compatibility, while not affecting other good implementations.
> The issue is, even if we can't find a userspace now. It doesn't mean
> we can't have one in the future. Then it might be too late or too
> tricky to fix them. We had a lot of lessons in the past.
I am not sure the same situation "too late to fix" or "too tricky to 
fix" applies here. Usually this means there's some well established 
pattern for e.g. API, ABI or long standing de-factor behavior that can't 
be broken or adjust if trying to fix something up. But here we're 
guarded by a flag (IOTLB_PERSIST) and without it the behavior is totally 
ruled by implementation.

Regards,
-Siwei

>
> Thanks
>
>> Thanks,
>> -Siwe/i/
>>
>>>>>> For two reasons:
>>>>>>
>>>>>> 1) backend features need acked by userspace this is by design
>>>>>> 2) keep the odd behaviour seems to be more safe as we can't audit
>>>>>> every userspace program
>>>>>>
>>>>> The old behavior (without flag ack) cannot be trusted already, as:
>>> Possibly but the point is to unbreak userspace no matter how weird the
>>> behaviour we've ever had.
>>>
>>>>> * Devices using platform IOMMU (in other words, not implementing
>>>>> neither .set_map nor .dma_map) does not unmap memory at virtio reset.
>>>>> * Devices that implement .set_map or .dma_map (vdpa_sim, mlx5) do
>>>>> reset IOTLB, but in their parent ops (vdpasim_do_reset, prune_iotlb
>>>>> called from mlx5_vdpa_reset). With vdpa_sim patch removing the reset,
>>>>> now all backends work the same as far as I know., which was (and is)
>>>>> the way devices using the platform IOMMU works.
>>>>>
>>>>> The difference in behavior did not matter as QEMU unmaps all the
>>>>> memory unregistering the memory listener at vhost_vdpa_dev_start(...,
>>>>> started = false),
>>>> Exactly. It's not just QEMU, but any (older) userspace manipulates
>>>> mappings through the vhost-vdpa iotlb interface has to unmap all
>>>> mappings to workaround the vdpa parent driver bug.
>>> Just to clarify, from userspace, it's the (odd) behaviour of the current uAPI.
>>>
>>>> If they don't do
>>>> explicit unmap, it would cause state inconsistency between vhost-vdpa
>>>> and parent driver, then old mappings can't be restored, and new mapping
>>>> can be added to iotlb after vDPA reset. There's no point to preserve
>>>> this broken and inconsistent behavior between vhost-vdpa and parent
>>>> driver, as userspace doesn't care at all!
>>> It's a userspace notice change so we can't fix it silently:
>>>
>>> https://lkml.org/lkml/2012/12/23/75
>>>
>>> Another example which is related to vhost-vDPA:
>>>
>>> https://lore.kernel.org/netdev/20230927140544.205088-1-eric.auger@redhat.com/T/
>>>
>>> Thanks
>>>
>>>>> but the backend acknowledging this feature flag
>>>>> allows QEMU to make sure it is safe to skip this unmap & map in the
>>>>> case of vhost stop & start cycle.
>>>>>
>>>>> In that sense, this feature flag is actually a signal for userspace to
>>>>> know that the bug has been solved.
>>>> Right, I couldn't say it better than you do, thanks! The feature flag is
>>>> more of an unusual means to indicating kernel bug having been fixed,
>>>> rather than introduce a new feature or new kernel behavior ending up in
>>>> change of userspace's expectation.
>>>>
>>>>> Not offering it indicates that
>>>>> userspace cannot trust the kernel will retain the maps.
>>>>>
>>>>> Si-Wei or Dragos, please correct me if I've missed something. Feel
>>>>> free to use the text in case you find more clear in doc or patch log.
>>>> Sure, will do, thank you! Will post v2 adding these to the log.
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>
>>>>
>>>>> Thanks!
>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>> I think
>>>>>>> the purpose of the IOTLB_PERSIST flag is just to give userspace 100%
>>>>>>> certainty of persistent iotlb mapping not getting lost across vdpa reset.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> -Siwei
>>>>>>>
>>>>>>> [1]
>>>>>>> https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com/
>>>>>>> [2]
>>>>>>> https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bfe5473f1f2e@oracle.com/
>>>>>>>>      Otherwise
>>>>>>>> we may break old userspace.
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>>> +       vhost_vdpa_reset_map(v, asid);
>>>>>>>>>             kfree(as);
>>>>>>>>>
>>>>>>>>>             return 0;
>>>>>>>>> --
>>>>>>>>> 1.8.3.1
>>>>>>>>>

