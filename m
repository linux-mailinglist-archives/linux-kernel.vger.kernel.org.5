Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D616C76F35C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjHCTVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjHCTVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:21:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422C0BA;
        Thu,  3 Aug 2023 12:21:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373JJZZ6032449;
        Thu, 3 Aug 2023 19:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=ZCnhilp0ZcR2qwT/hDKmsy1NSsdhrk5WVNfkLBOCyyg=;
 b=VhuUd1tI/tMPzDj05+ixUDKZ4XD3EvlIB8MXMrBNNLa04vTBPX7i5J4PlxIBb4122tVD
 i3tFSb6FhacvyeMAMrSQHlLrjeMZfXdV+LADWVHBHfiQKAsor+m4JOqRD7X3ykZ9HFvb
 2exJiVgJHjIumAhOqiXBB/0FOTqgRb78yYByat/HBLXaD+sryxVBCKo/ftTHgAKu0QuI
 uNixHtuyPOhnSzFVRnc8WqeZPqnbTBKNsuP+vLsDALtdzt0LMi7u3c6Pkwhq2c8leuAn
 msRpWVy9yJc86bC2h/uxluDGql6088AgHu3NvoQn/FUOm92e/UsJzvvKzG99oM/hew0u XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tnbjd4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 19:20:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373HvkTE003318;
        Thu, 3 Aug 2023 19:20:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s856rvgkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 19:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZKCnCYKGlnUDIgBnHWXXQX2SC97S/OOnccuWL3VbyKpMN/6M7lXdkjxt6YfgCtGzbp+gJLBfKiz6UK1bdAVA1B//Cu1vpXy4kD7JaXjCGIXzRbyCKaL+lb499455gLA186dWXW7HibwPE2SGr0FBd8PjI8oq0Ms5HNtwjeGlk76RiMqQ6pErM0daQoEnbY0vCv5vDeC1HOa8XmeBcIdnZHARUjaOX++VJgIl74qwwnt/E8IVYS9ixioaCmLmjoQjgZxVUMuVA2K8oa/MelvxwgGaOmBRuBQ30eioXY1kJUDUUaKsdfzFXvVTZ2CG4xlxJ+bGdfe8SKpj+lSt1Jznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCnhilp0ZcR2qwT/hDKmsy1NSsdhrk5WVNfkLBOCyyg=;
 b=fu0dsBJ9yBYp7LMuQ3qduiU+rz7t66pjbITVsIgozULeC9pzyvXTpOdcrmfBz1rGn9ORToR5L96eUIzBg25h9XoVqBknbVYJK+1ki3klHUH+YEC038GIVv/9Yvd/SLn4YpT99gA2H2g7h+F6Yf5tjmH0Y4NVXUvo7eitC2VB1RaSVuMZsri4yqpJVLus9owVSCtAUEEGh8b9HmDRrYU7klU3hRyTjNVRInOgWvcHiioTIvVbMavyM1UTyixXqpcU2YnEj5zb84uUhynAEQZZX213PF1rJ0zZS3H+BNA/nVGZy7h5Fz04fuXOUZbHhjLOa8p5wfbudhZKGgcUEvrVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCnhilp0ZcR2qwT/hDKmsy1NSsdhrk5WVNfkLBOCyyg=;
 b=eCgyFKtLYBio5D9F2KsaczOT7HhHO4Fjgdt/qbGYGqUf4antFKp43H+hVm45/ohofc7pvV5Zrn+wnJrjv0MrIKlqAj5mPatIbhGVpXTeIhq7Rn+ekKU51vaRTAd1aq8Kl4PZ9mO0VjSHoDR+wG5czO5vgCC6mk4W6TrrAgBes7Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7334.namprd10.prod.outlook.com (2603:10b6:208:3fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 19:20:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 19:20:32 +0000
Date:   Thu, 3 Aug 2023 15:20:29 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v3 6/6] mm: move vma locking out of vma_prepare and
 dup_anon_vma
Message-ID: <20230803192029.ykcxc647fihar46c@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
References: <20230803172652.2849981-1-surenb@google.com>
 <20230803172652.2849981-7-surenb@google.com>
 <20230803183228.zreczwv3g3qp4kux@revolver>
 <CAJuCfpHUp5xVV-p=pKXp6javYq+GmUx_3cDKr9mmTnHYxsg0Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpHUp5xVV-p=pKXp6javYq+GmUx_3cDKr9mmTnHYxsg0Mw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MN2PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:208:d4::45) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: ae476c61-0b0f-448b-1059-08db9456b48c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klVv5v2evYeppGFuob4+qULwfvswnwKXhIBxB+Aafye4SgZIFL8idDziTq/9eZ2CR8OBBX6l/+aZze/VE6++IqVAB3dE9zv3VT/RkR9hQJiCB467cv2IVYZR372E3ihDwSFIGimulS6OXS63cR5ozUwB8QWkcBKpc97s5ZLipihKHyM1Y8oS0UPXRBk8ANgXOrdQAZmVQHqzUYCVOzyZtXSrQcDKsALvLpXmgesK46VPnMAAzTqF/kbyR3TVV2y6mcEW+/lPQ+4Lo8dqKTEtB1gkWAsNjpI5aAsFxhsbrBteCRuI9PuybycRRTE99x1BESZQzmUu47JyBo2Lo2/MxE5Eb7W7pNfydJkYLaekWPPcg5CiuHNUiF7QU4wgoiz3RxsKtMxvoQnRjITGTEsEIPDPmy7lgXW5GoUT5d6plquT32hOiNkTnJbPfYlHl9btPcPfp1iBLlpCPG43JPkiLZNNTd28HkISAndpswcYf9kO9R8xD0xrYyplYlqEKD3di5AVhjOYv1dpzoFkOvAjNJy7aKJOcfbbkvID44YiCicy78qLYQWh4dQbsiAZWlRB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(86362001)(33716001)(478600001)(38100700002)(1076003)(6506007)(186003)(26005)(83380400001)(8676002)(53546011)(41300700001)(7416002)(8936002)(6512007)(9686003)(6486002)(6666004)(316002)(66556008)(66476007)(2906002)(6916009)(5660300002)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0tMLzJ2YVlyRVFSQmxRcVFQYWZRRzFGZlBUT3VJNlErQmxBQXZiQmIySldW?=
 =?utf-8?B?ZWpidWRzVVhPclRwNDNSanVHYVdoaUxBWnhZSW1mcnBjL3ZjWnBOazdQUk9B?=
 =?utf-8?B?ZWo1ZEZkTGN5S0hoSnFvMndwK25QaTVMZ0ZzYmxONjI0b1hkS1VrUHlQakZ5?=
 =?utf-8?B?dzZJZC9tNUdYT3Z6WDU0Z0lLa0h3dTF6NjJIMHhIZVFYSms3dTNjd3FaWTJl?=
 =?utf-8?B?UGlFbDRxV2lKalZRWjlscm81RHdkazNvaTlMZWxoenBPVS9JRFl1Nk1vazYw?=
 =?utf-8?B?VzB2c1daNjFTOEtFUWNHaC9MZkd2eWlPQWVFMUJtUXBZLzBEMFM4VitqVmpO?=
 =?utf-8?B?LzVXZmprSEVEbXFVdXZrSnB2cHpMTXJVc2FZMGo0ZWVtZjZMQ3lQVzZCZWxH?=
 =?utf-8?B?bDJUb1V2d2xEREMwYWNFRjcwUmhBcU1yQ0ZoQ2ZObm1pVGQrYW1JRk13eXN6?=
 =?utf-8?B?b094bVJjS0ROS25FeC9xYmRrMlNkRjZpbElrRDAwSUZCUkhHam5xZTBBWWMx?=
 =?utf-8?B?UlJ4bEJHMUVHcEdJTTBDcjBnaTJvSWNBS3I4RHhSR0d3aFhNT3IwOGVyVFBH?=
 =?utf-8?B?V1JJMUZWTVI2SEtOdVMrSVBGbVgxQUNKcVNIRDNOL2twVzNVRE54aTE4Qk1F?=
 =?utf-8?B?aG02SmYrUGthQUcyWmpNREVoRm9pMnVSQXRzOEp5VitmbXhEZmFzYkpGbWJj?=
 =?utf-8?B?K3ZLVVBpMFlnT0l1ZmppZlNCaXJXMytlcjJLeXNqcGFQUzgxOUZQbVl6QXo4?=
 =?utf-8?B?a3FjdmdOSDlOaTNFOGNIOGFDNXU4TDQvYWVndDNET3JGUm14R0g4cnhOV1lQ?=
 =?utf-8?B?aWJJWmU0eXBKQzkwWEJUTWV4ZTZYWTB1YWtQTDB1bFM5eXpPRXJlVGVtYU5v?=
 =?utf-8?B?bTdpZXVoeXpMeEZ4aDFKTGtJN0hsMC9yQWN2MnROUjU2K0U1RXdOTEdRTE1r?=
 =?utf-8?B?ZHpZSjVMd0xZNDRkRFU4ZklkU1htbG96NHAzNXRHTHZLN0tkeXYwMzAxY1B6?=
 =?utf-8?B?eDVCTDc4N0RsTXVYNnFHTGVOSXhNUndKSnFpZnNyaHRUVEoyZG9mVkQ2d3ZD?=
 =?utf-8?B?L2p0OVZ3UDhqSmtXNWpHMDZZVSt4REZSSTlSMS9jRlBLNTZBQ2xlK2RObDVW?=
 =?utf-8?B?T0xqZG9ieitkaHFPMTB0bmVkMlRUcDM4SEJjTzlkZEs5ZXJWemxjanA0ZzRZ?=
 =?utf-8?B?ajF2NWVHK093dndwOTNieFNlN3o3WjE3ZWZMbFFSUFZIaDBUb2h0SVdCYnpy?=
 =?utf-8?B?Vko4YlZnZ2NpZTIyTUN5eE9WdGpuVTdHVVE3bGI4OWU0SGtWVEd4NTNaUmox?=
 =?utf-8?B?M0EydEQxMXFWZ3RkdUoweEhKTUkvSU5DMHREMk9HT1lxdmlOYmZPbzJkUW43?=
 =?utf-8?B?K2Q0YW40c1lzMldjYlZ0VTNlRHUxN3NKbTZ0ZWZ3MmJHalFpVXpPQWEveFJ5?=
 =?utf-8?B?VmZ4MGhoNUZ4cEhOZFBsSURsYm02TlNKNlcxRStZOU0xQ3BjYzlIQmU3TFRV?=
 =?utf-8?B?YTRjWHlZamNiOUxlemZ6bXFBaWFoNmwzN1NYcEQyU1ExSWh3REtQOEJPVTRD?=
 =?utf-8?B?Ui9NV0xlcHNYYm1OUnNkYis0ZFlWWTVmRG9GREpFWjdKKzVERHZEbDd6RE1N?=
 =?utf-8?B?Z2dsRVovVlUvOU9hRjBQWUhRS1hRcTU0Yjcxc3o1cWhGbU5pL0Y5M1UrWkpL?=
 =?utf-8?B?RXNUMmk5QlpDV2l3VWpuTGNVTGN3RC9lUWp2OG1GOThUVWZ3YVhkVHpIN2Fn?=
 =?utf-8?B?U05GNy9pN1BHcEh3QnZ5bmphZVgvTEFnWXhwbFhwVDVUblJtWUJmSWZ5MDRk?=
 =?utf-8?B?eHBhc2hxeUZ0Z3BXVmp6VlRXZHIyVmVsWUV2MHJjYzFFUm5tb3lGUUF4S0NN?=
 =?utf-8?B?Q2pzcWh1YzRWZ1dmT1lXcmtla2lsV0FPOTlFLzRid2VzNzRHaWo0ejNJa0VJ?=
 =?utf-8?B?Nm16czBsZWo3WjRlUDlQMkxmK0h5ayt6cXlXaC9EL3pLYmxZYm5HUW1jR1pK?=
 =?utf-8?B?S1ltejIyU01QUnBRbW1XbU1MNGxwdVJ5bUw5ME0zTmZUNTlEakFnWHZqbzNm?=
 =?utf-8?B?VG41MFIraUpxaW9KcnlBSVhpYjdGQ3BsblVCMG5xRlIxTVN4cmQvbGxoM0tk?=
 =?utf-8?B?WVYrSGJDOTRYWW5sbEtDZVFMajY2UDVSS0ltS3B4djNaSjkwZzFFK2VLYk9h?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OGRKbVRLL245V2RxQ2RQM0Z2NFNXQ0tYT0lxNVM0UDI5OW9oWk12VW43Q1lj?=
 =?utf-8?B?Q0hYRUUvTzZOZEJyd1Jya2V5Y25kaXFrQjFwaUhGS1JyVlREeGNCS1ZUQmN4?=
 =?utf-8?B?WUlma3p1WEsyTXdUMmZYcjhYSnVFNVpSN0QxOVNmMUpHc3c3S1lqNkN3SHpR?=
 =?utf-8?B?bHhaZ1A2cFJGQy9rNHplU3piRTQ2THN4SVkyYTZTQm1TcXd1L2tURUVHcDZK?=
 =?utf-8?B?eDJKY3kvMTR2RXdVVjQ5Z0JOOGZuN3dsL2NFd3FBekFMYXJ4cTNiaUF1TXNI?=
 =?utf-8?B?cDk2ckRNTC8xd2xZTHNrZlF5SVhYVG9wSGErQ2xJVUJsdXpxdmFTSENGcFNS?=
 =?utf-8?B?SUxRaysyZ09ZeG1KV3kva09UQmcrNDg2ZlAva1dKdEQxeHI5eUJLQmdtRUU0?=
 =?utf-8?B?eTkvU29IQktwN2oxUDJvVG9oNTdoTGRyNkFhanhsM2pzeTF6Ky9BNjhlU0I1?=
 =?utf-8?B?Q3grTm1sYzBjbTJ0VXE0ZVVlVUZsMHRHTmFqWGUrR3Z5ZUFodWVCK2RQVmFo?=
 =?utf-8?B?a3VzM1BZVnBkLzlZQitnR01mM016V2ZIaUNFaDd1T2Vvd3d1QW9MaHAxcXQy?=
 =?utf-8?B?bXJtNDhJbUY1UTViaFJBbmlNaGFzMkZROHNuQ1dFc2RnOUQ2QWNwblZoclBB?=
 =?utf-8?B?WjFQakVtL2NpazFMREp1Tm01eTZ6SjJubnVaSkNhTWhyV0VTbGlYNkEyTmxQ?=
 =?utf-8?B?dTZJN3Q3dHduM0RiZzZNTXB3cHg3USt6TDluWU5qM3dHUUNQRXlVQXg2M3hx?=
 =?utf-8?B?WmtsZG15cTNIN040UUNKcktuemY2Q1Zyc0pkTXdPSnlIWUpTNUVrQ1Y3WFM4?=
 =?utf-8?B?OCt3RFpFY2JFbitSVzdONHdOZ0VYOExYS0xZR2pzZ3ZGcjhKVFpxL2Iwdis0?=
 =?utf-8?B?SHA2ZFZrNmN0RlNPUnQvTXhlWElwNUFoenVsRG5MMmhDOWwwd1JNUVFBN0sy?=
 =?utf-8?B?OE5GQWJPVTRRcGN1SEZGSGZVZmRxSFRhUm9Jb1JCcUJCU1ZkSWppMTFmc1o5?=
 =?utf-8?B?bU5RZkNpTDdYZGtsdUNpNm5aSUVTZ3d4VjgvZ3VMYzJRTnViT0gzV1lXbkI3?=
 =?utf-8?B?aTVQenFrejBqL2xWbkNIZ2Q1YkhZdVhVVlpWSUZwV2dxSmFnL25rZXZsV2ZU?=
 =?utf-8?B?TjNIbEh3L3JkMzBQTWRBMjJkc2N5K1NDcEV2UmJpcU1ieE5kRmlaR2srOXZI?=
 =?utf-8?B?bmVMU0IvZFZPMWpNZGdYRVE4WlhlR0tmNEw3cWoybnpDV2IwTkF2ZWxTdkov?=
 =?utf-8?B?ZXpnOFJvNWhRK1laLy9TNkpyTlZwREhBcGNQak52TXFoSjM4eXkyeXVWeEJR?=
 =?utf-8?B?SU80a2FHSW5nY0ZOaWozbEZRQUd3emtZUWpGY2tDVVB4b1ZXT1hTKzB5b1Jr?=
 =?utf-8?B?cnNiN2xrZkFJMTJGNmhPaWlHMUJzUStzYnRKSUYwamQxYytCVXJ0TCtVaUdr?=
 =?utf-8?B?V2g1eVk5MHZYR1l1RFVqYTZuMkh3eHF6Y1RNSG9FaEZmeStaRDBqSFp3UndV?=
 =?utf-8?B?UXZrMUhkL3dtU2NRQjZPRENZQ0lyd29SVEtvY0VmRXlQTDdORHJOMW84dE4w?=
 =?utf-8?Q?eaJWfGy3sil7A3MB0wQih62us=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae476c61-0b0f-448b-1059-08db9456b48c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 19:20:32.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4e0vPKLX1+eMbWmhfaGXOQdINLXAWHApnilf8dQC6YWjOlTsZHs0paRpDoeJaa0NtmW4AfPu+zWdUetucPwzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_20,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030174
X-Proofpoint-ORIG-GUID: b0G_q93J5LB_DMyYvAX1-FEJZKzWqJVC
X-Proofpoint-GUID: b0G_q93J5LB_DMyYvAX1-FEJZKzWqJVC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230803 15:16]:
> On Thu, Aug 3, 2023 at 11:32=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [230803 13:27]:
> > > vma_prepare() is currently the central place where vmas are being loc=
ked
> > > before vma_complete() applies changes to them. While this is convenie=
nt,
> > > it also obscures vma locking and makes it harder to follow the lockin=
g
> > > rules. Move vma locking out of vma_prepare() and take vma locks
> > > explicitly at the locations where vmas are being modified. Move vma
> > > locking and replace it with an assertion inside dup_anon_vma() to fur=
ther
> > > clarify the locking pattern inside vma_merge().
> > >
> > > Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> > > Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  mm/mmap.c | 29 ++++++++++++++++++-----------
> > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 850a39dee075..ae28d6f94c34 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -476,16 +476,6 @@ static inline void init_vma_prep(struct vma_prep=
are *vp,
> > >   */
> > >  static inline void vma_prepare(struct vma_prepare *vp)
> > >  {
> > > -     vma_start_write(vp->vma);
> > > -     if (vp->adj_next)
> > > -             vma_start_write(vp->adj_next);
> > > -     if (vp->insert)
> > > -             vma_start_write(vp->insert);
> > > -     if (vp->remove)
> > > -             vma_start_write(vp->remove);
> > > -     if (vp->remove2)
> > > -             vma_start_write(vp->remove2);
> > > -
> > >       if (vp->file) {
> > >               uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_e=
nd);
> > >
> > > @@ -618,7 +608,7 @@ static inline int dup_anon_vma(struct vm_area_str=
uct *dst,
> > >        * anon pages imported.
> > >        */
> > >       if (src->anon_vma && !dst->anon_vma) {
> > > -             vma_start_write(dst);
> > > +             vma_assert_write_locked(dst);
> > >               dst->anon_vma =3D src->anon_vma;
> > >               return anon_vma_clone(dst, src);
> > >       }
> > > @@ -650,10 +640,12 @@ int vma_expand(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
> > >       bool remove_next =3D false;
> > >       struct vma_prepare vp;
> > >
> > > +     vma_start_write(vma);
> > >       if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
> > >               int ret;
> > >
> > >               remove_next =3D true;
> > > +             vma_start_write(next);
> > >               ret =3D dup_anon_vma(vma, next);
> > >               if (ret)
> > >                       return ret;
> > > @@ -708,6 +700,8 @@ int vma_shrink(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
> > >       if (vma_iter_prealloc(vmi))
> > >               return -ENOMEM;
> > >
> > > +     vma_start_write(vma);
> > > +
> > >       init_vma_prep(&vp, vma);
> > >       vma_prepare(&vp);
> > >       vma_adjust_trans_huge(vma, start, end, 0);
> > > @@ -940,16 +934,21 @@ struct vm_area_struct *vma_merge(struct vma_ite=
rator *vmi, struct mm_struct *mm,
> > >       if (!merge_prev && !merge_next)
> > >               return NULL; /* Not mergeable. */
> > >
> > > +     if (prev)
> >
> > Maybe if (merge_prev) instead of prev?  We will write lock prev if it
> > exists and won't change with the current check (case 3 and 8,
> > specifically), with this change case 4 will need to lock prev as it
> > shifts prev->vm_end lower.
>=20
> Ah, I see. I was trying to make sure we don't miss any locks and
> over-locked it for case 3 and 8.
> Ok, I'll change the check to if (merge_prev) and will add a separate
> locking for case 4. I think that's what you meant?

Yes, I think that will cover all the cases.  Thanks.

>=20
> >
> > > +             vma_start_write(prev);
> > > +
> > >       res =3D vma =3D prev;
> > >       remove =3D remove2 =3D adjust =3D NULL;
> > >
> > >       /* Can we merge both the predecessor and the successor? */
> > >       if (merge_prev && merge_next &&
> > >           is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)=
) {
> > > +             vma_start_write(next);
> > >               remove =3D next;                          /* case 1 */
> > >               vma_end =3D next->vm_end;
> > >               err =3D dup_anon_vma(prev, next);
> > >               if (curr) {                             /* case 6 */
> > > +                     vma_start_write(curr);
> > >                       remove =3D curr;
> > >                       remove2 =3D next;
> > >                       if (!next->anon_vma)
> > > @@ -957,6 +956,7 @@ struct vm_area_struct *vma_merge(struct vma_itera=
tor *vmi, struct mm_struct *mm,
> > >               }
> > >       } else if (merge_prev) {                        /* case 2 */
> > >               if (curr) {
> > > +                     vma_start_write(curr);
> > >                       err =3D dup_anon_vma(prev, curr);
> > >                       if (end =3D=3D curr->vm_end) {      /* case 7 *=
/
> > >                               remove =3D curr;
> > > @@ -966,6 +966,7 @@ struct vm_area_struct *vma_merge(struct vma_itera=
tor *vmi, struct mm_struct *mm,
> > >                       }
> > >               }
> > >       } else { /* merge_next */
> > > +             vma_start_write(next);
> > >               res =3D next;
> > >               if (prev && addr < prev->vm_end) {      /* case 4 */
> > >                       vma_end =3D addr;
> > > @@ -983,6 +984,7 @@ struct vm_area_struct *vma_merge(struct vma_itera=
tor *vmi, struct mm_struct *mm,
> > >                       vma_pgoff =3D next->vm_pgoff - pglen;
> > >                       if (curr) {                     /* case 8 */
> > >                               vma_pgoff =3D curr->vm_pgoff;
> > > +                             vma_start_write(curr);
> > >                               remove =3D curr;
> > >                               err =3D dup_anon_vma(next, curr);
> > >                       }
> > > @@ -2373,6 +2375,9 @@ int __split_vma(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
> > >       if (new->vm_ops && new->vm_ops->open)
> > >               new->vm_ops->open(new);
> > >
> > > +     vma_start_write(vma);
> > > +     vma_start_write(new);
> > > +
> > >       init_vma_prep(&vp, vma);
> > >       vp.insert =3D new;
> > >       vma_prepare(&vp);
> > > @@ -3078,6 +3083,8 @@ static int do_brk_flags(struct vma_iterator *vm=
i, struct vm_area_struct *vma,
> > >               if (vma_iter_prealloc(vmi))
> > >                       goto unacct_fail;
> > >
> > > +             vma_start_write(vma);
> > > +
> > >               init_vma_prep(&vp, vma);
> > >               vma_prepare(&vp);
> > >               vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0=
);
> > > --
> > > 2.41.0.585.gd2178a4bd4-goog
> > >
